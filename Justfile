#! /usr/bin/env just --justfile

_default:
    @just --list

# Format various files
format:
    #!/usr/bin/env bash
    set -euo pipefail

    biome() {
      command npx --yes @biomejs/biome@2 "$@"
    }

    mapfile -t managed < <(chezmoi managed --path-style source-absolute)

    find_files() {
      local ext shebang
      ext="${1}"
      shebang="${2}"
      shift 2

      {
        [[ -n "$ext" ]] && fd -H -e "$ext"
        [[ -n "$shebang" ]] && rg -l -m1 "$shebang" "${managed[@]}" 2>/dev/null
        (($#)) && printf '%s\n' "$@"
      } | sort -u
    }

    biome migrate --config-path=biome.json --write
    biome check --config-path=biome.json --write biome.json
    biome check --config-path=biome.json --fix home/.chezmoitemplates/finicky/finicky.ts

    find_files sh.tmpl '' lib/lib.bash | xargs shfmt -w
    # find_files '' '^#!.*\bbash' | xargs shfmt -w

    mapfile -t pythons < <(find_files py '^#!.*\bpython\d?' home/private_dot_pythonrc)

    ruff check --fix "${pythons[@]}"

    mapfile -t rubies < <(find_files rb '^#!.*ruby' lib/update.rb)
    standardrb --fix "${rubies[@]}"

# Update all package files
update-packages: ports homebrew rust code ruby python gh-extensions

# Update MacPorts packages
ports:
    @ruby lib/update.rb ports

# Update Homebrew packages
homebrew:
    @ruby lib/update.rb homebrew

# Update GitHub Extensions
gh-extensions:
    @ruby lib/update.rb gh_extensions

# Update Rust binaries (using 'cargo-liner')
rust:
    @cargo liner import --force -qq
    @sed -E -e 's/= "([^"]+)"/= { version = "\1", locked = true }/g' \
      -e 's/\^//g' \
      ~/.cargo/liner.toml | sponge ~/.cargo/liner.toml
    @vimdiff ~/.cargo/liner.toml home/private_dot_cargo/liner.toml.tmpl

# Update Visual Studio Code packages
code:
    @ruby lib/update.rb vscode

# Update Ruby-based dependencies
ruby: _ruby_gems

# Update Python-based dependencies
python: _python_uv

_python_uv:
    @ruby lib/update.rb python_uv

_ruby_gems:
    @ruby lib/update.rb ruby_gems
