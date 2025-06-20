#! /usr/bin/env ruby

require "fileutils"
require "json"
require "net/http"
require "shellwords"
require "tmpdir"

def role_data
  @role_data ||= JSON.parse!(`chezmoi execute-template '{{ template "roles/selected" . }}'`)
end

def tmpdiff(target, lines, debug)
  return lines if debug

  tmpdir = Dir.mktmpdir

  begin
    left = File.join(tmpdir, File.basename(target, ".tmpl"))
    data = lines.join("\n") + "\n"
    File.write(left, data.gsub("\n\n\n", "\n\n"))

    right = File.join(tmpdir, File.basename(target))
    data = `chezmoi execute-template <#{target}`.chomp.gsub(/^# /, "").gsub(/\s+$/, "")
    File.write(right, data)

    spawn(["vimdiff", left, right].shelljoin)
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
  fetch_json(url)["gems"].map { it["gem"] }
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

def macports_info
  requested = `port echo requested`.split($/).map {
    port = it.gsub(/@[^+][^+]*/, "").gsub(/\s+/, " ").sub(/\s+$/, "")
    "install #{port}"
  }.sort_by(&:downcase).uniq

  select =
    `port select --summary`.split($/).tap { it.shift(2) }.map {
      case it.split
      in [_, "none", *]
        nil
      in [target, port, *]
        "select --set #{target} #{port}"
      end
    }.compact

  requested + select
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

MAS_EXCLUSIONS = [
  682658836, # GarageBand
  409183694, # Keynote
  409203825, # Numbers
  409201541, # Pages
  408981434 # iMovie
].join("|")

def update_homebrew
  data = homebrew_bundle.tap { it.delete("vscode") }
  data["mas"]&.delete_if { it =~ /id: (?:#{MAS_EXCLUSIONS})$/o }

  {
    target: "home/private_dot_config/packages/Brewfile.tmpl",
    data: data,
    transform: ->(data) { data.keys.flat_map { data[it].sort_by(&:downcase) << "\n" } }
  }
end

def update_vscode
  {
    target: "home/private_dot_config/packages/vscode.tmpl",
    data: homebrew_bundle["vscode"],
    transform: ->(data) {
      data.sort_by(&:downcase).flat_map {
        it.scan(/\Avscode "([^"]+)"(?: (#.+))?\z/).flatten.compact
      }
    }
  }
end

def update_ports
  {
    target: "home/private_dot_config/packages/ports.tmpl",
    data: macports_info,
    transform: ->(data) { data }
  }
end

def update_ruby_gems
  {
    target: "home/private_dot_config/packages/Gemfile.tmpl",
    data: only_local_gems,
    transform: ->(data) { data.map { %(gem "#{it}") } }
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

def update_gh_extensions
  {
    target: "home/private_dot_config/packages/executable_gh-extensions.tmpl",
    data: `gh extension list`.split($/).tap { it.shift }.map {
      "gh extension install #{it.split("\t")[1]}"
    }.sort_by(&:downcase),
    transform: ->(data) { ["#!/bin/sh", "\n", *data] }
  }
end

def update_python_uv
  tools = `uv tool list --show-paths`
    .split($/)
    .reject { it =~ /^-/ }
    .flat_map { it.gsub(/\A([^ ]+) v.+ \(.+\)\z/, 'uv tool install \1') }

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
