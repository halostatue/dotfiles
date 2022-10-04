#! /usr/bin/env just --justfile

default:
  @just --list

update-packages: update-homebrew update-gems update-python update-ports

update-homebrew:
  @brew bundle dump --force --file=Setup/Brewfile

update-gems:
  @printf "gem \"%s\"\n" `(gem list --no-versions)` > Setup/Gemfile

update-python:
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

    [install, inject].compact.join(" && ")
  }.join("\n")

  File.write("Setup/Pipx.fish", result)

update-ports:
  @port -qv installed > Setup/Ports.installed
  @port echo requested | cut -d' ' -f1 | uniq > Setup/Ports.requested
