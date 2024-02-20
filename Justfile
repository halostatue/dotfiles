#! /usr/bin/env just --justfile

_default:
  @just --list

# Update all package files
update-packages: update-homebrew update-gems update-pipx update-ports

# Update Homebrew Brewfile
update-homebrew:
  #!/usr/bin/env ruby

  require "tmpdir"

  dump = %x(brew bundle dump --force --file=- --describe).split($/)
  lines = Hash.new { |h, k| h[k] = [] }
  comment = nil

  dump.each do |line|
    line.chomp!
    if line.start_with?("#")
      comment = line
    else
      key = line.split(" ").first
      key = "#{key}-font" if line.include?('"font-')

      if comment
        lines[key] << "#{line} #{comment}"
        comment = nil
      else
        lines[key] << line
      end
    end
  end

  tmpdir = Dir.mktmpdir

  File.write(
    File.join(tmpdir, "Brewfile"),
    lines.keys.map { lines[_1].sort.join("\n") }.join("\n")
  )

  exec("vimdiff '#{tmpdir}/Brewfile' 'Setup/Brewfile'")

# Update the default Gemfile
update-gems:
  #!/usr/bin/env ruby

  require "json"
  require "net/http"
  require "tmpdir"

  def fetch(url)
    JSON.parse(Net::HTTP.get(URI(url)))["gems"].map { _1["gem"] }
  end

  def local_gems
    %x(gem list --no-versions).split($/)
  end

  rubys_gems = fetch("https://stdgems.org/default_gems.json") +
   fetch("https://stdgems.org/bundled_gems.json")

  gems = (local_gems - rubys_gems).map { %Q(gem "#{_1}") }.join("\n")

  tmpdir = Dir.mktmpdir

  File.write(File.join(tmpdir, "Gemfile"), gems)

  exec("vimdiff '#{tmpdir}/Gemfile' 'Setup/Gemfile'")

# Update the default pipx list of files
update-pipx:
  #!/usr/bin/env ruby

  require "json"

  packages = JSON.parse(`pipx list --json`)["venvs"]
  result = packages.values.map { |package|
    main = package["metadata"]["main_package"]

    name = main["package"]
    url = main["package_or_url"]
    suffix = main["suffix"] unless main["suffix"].nil? || main["suffix"].empty?
    deps = main["include_dependencies"]
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

    inject = nil if inject.empty?

    [install, inject].compact.join(" &&\n  ")
  }.join("\n")

  File.write("Setup/Pipx.fish", result + "\n")

  # pipx list --include-injected --json | jq -f Setup/pipx-reinstall.jq > Setup/pipx.fish.new -r

# Update the requested ports
update-ports:
  #!/usr/bin/env bash

  set -euo pipefail

  declare tmp
  tmp="$(mktemp -d)"
  port echo requested |
    sed -e 's/  */ /' -e 's/\@[^+][^+]*//' -e 's/ $//' |
    uniq > "${tmp}/Ports"
  vimdiff "${tmp}/Ports" "Setup/Ports"
