#! /usr/bin/env just --justfile

_default:
    @just --list

# Format various files
format:
    @npx @biomejs/biome check --config-path=biome.json --write biome.json
    @npx @biomejs/biome check --config-path=biome.json --fix \
      --stdin-file-path=finicky.js <home/private_dot_finicky.js.tmpl | \
      sponge home/private_dot_finicky.js.tmpl
    @shfmt -w home/.chezmoiscripts/* lib/lib.bash lib/update.sh
    @standardrb --fix lib/update.rb

# Update all package files
update-packages: ports homebrew go rust code ruby python

# Update MacPorts packages
ports:
    @lib/update.sh ports

# Update Homebrew packages
homebrew:
    @ruby lib/update.rb homebrew

# Update Go binaries (using 'gup')
go:
    @lib/update.sh go

# Update Rust binaries (using 'cargo-liner')
rust:
    @cargo liner import --force --compatible --keep-self --keep-local -qq
    @sed -E 's/= "([^"]+)"/= { version = "\1", locked = true }/g' ~/.cargo/liner.toml | sponge ~/.cargo/liner.toml
    @vimdiff ~/.cargo/liner.toml home/private_dot_cargo/liner.toml.tmpl

# Update Visual Studio Code packages
code:
    @ruby lib/update.rb vscode

# Update Ruby-based dependencies
ruby: _ruby_gems

# Update Python-based dependencies
python: _python_pipx _python_uv

_python_pipx:
    @ruby lib/update.rb python_pipx

_python_uv:
    @ruby lib/update.rb python_uv

_ruby_gems:
    @ruby lib/update.rb ruby_gems
