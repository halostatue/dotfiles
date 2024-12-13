#! /usr/bin/env ruby

require "fileutils"
require "json"
require "net/http"
require "shellwords"
require "tmpdir"

def tmpdiff(target, lines, debug)
  return lines if debug

  tmpdir = Dir.mktmpdir

  begin
    tmp = File.join(tmpdir, File.basename(target, ".tmpl"))
    data = lines.join("\n") + "\n"
    File.write(tmp, data.gsub("\n\n\n", "\n\n"))
    spawn(["vimdiff", tmp, target].shelljoin)
    Process.wait
  ensure
    FileUtils.rm_rf(tmpdir)
  end
end

def update(fun, debug = nil)
  __send__(:"update_#{fun}") => {target:, data:, transform:}
  data = transform.call(data) if transform
  tmpdiff(target, data, debug)
end

def fetch_json(url)
  JSON.parse(Net::HTTP.get(URI(url)))
end

def fetch_gem_json(url)
  fetch_json(url)["gems"].map { _1["gem"] }
end

def local_gems
  `gem list --no-versions`
    .split($/)
end

def only_local_gems
  default_gems =
    fetch_gem_json("https://stdgems.org/default_gems.json") +
    fetch_gem_json("https://stdgems.org/bundled_gems.json")
  local_gems - default_gems
end

def homebrew_bundle
  comment = nil
  `brew bundle dump --force --file=- --describe`
    .split($/)
    .each_with_object(Hash.new { |h, k| h[k] = [] }) { |line, lines|
      line.chomp!
      if line.start_with?("#")
        comment = line
        next
      end

      key = line.split(" ").first
      key = "#{key}-font" if line.include?('"font-')

      if comment
        line = "#{line} #{comment}"
        comment = nil
      end

      lines[key] << line
    }
end

def update_homebrew
  {
    target: "home/private_dot_config/packages/Brewfile.tmpl",
    data: homebrew_bundle.tap { _1.delete("vscode") },
    transform: ->(data) {
      data.keys.flat_map { data[_1].sort << "\n" }
    }
  }
end

def update_vscode
  {
    target: "home/private_dot_config/packages/vscode.tmpl",
    data: homebrew_bundle["vscode"],
    transform: ->(data) {
      data.sort.flat_map {
        _1.scan(/\Avscode "([^"]+)"(?: (#.+))?\z/).flatten.compact
      }
    }
  }
end

def update_ruby_gems
  {
    target: "home/private_dot_config/packages/Gemfile.tmpl",
    data: only_local_gems,
    transform: ->(data) {
      data.map { %(gem "#{_1}") }
    }
  }
end

def update_python_pipx
  packages = JSON.parse(`pipx list --json`)["venvs"]
  data = packages.values.flat_map { |package|
    main = package["metadata"]["main_package"]

    name = main["package"]
    url = main["package_or_url"]
    suffix = main["suffix"] unless main["suffix"].nil? || main["suffix"].empty?
    main["include_dependencies"]
    pip_args = main["pip_args"] unless main["pip_args"].nil? || main["pip_args"].empty?

    install = %w[pipx install]
    install << url
    install << "--include-deps" if main["include_dependencies"]
    install.push("--suffix", suffix) if suffix
    install.push("--pip-args", pip_args.join(" ")) if pip_args
    install = install.join(" ")

    inject = package.dig("metadata", "injected_packages").values.group_by { |v|
      {"apps" => v["include_apps"], "deps" => v["include_deps"]}
    }.values.map { |injectables|
      opts = injectables.first

      pkg = []
      pkg << "--include-apps" if opts["include_apps"]
      pkg << "--include-deps" if opts["include_deps"]

      injectables.each { |i| pkg << i["package_or_url"].delete(" ") }

      ["pipx", "inject", name, *pkg]
    }.join(" ")

    if inject.empty?
      [install]
    else
      [install, " &&", "  #{inject}"]
    end
  }

  {
    target: "home/private_dot_config/packages/executable_pipx.tmpl",
    data: data,
    transform: nil
  }
end

def update_python_uv
  tools = `uv tool list --show-paths`
    .split($/)
    .reject { _1 =~ /^-/ }
    .flat_map { _1.gsub(/\A([^ ]+) v.+ \(.+\)\z/, 'uv tool install \1') }

  {
    target: "home/private_dot_config/packages/executable_uv.tmpl",
    data: tools,
    transform: nil
  }
end

case ARGV[0]
when "debug"
  pp update(ARGV[1], :debug)
else
  update(ARGV[0])
end
