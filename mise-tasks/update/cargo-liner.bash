#!/usr/bin/env bash
#MISE description="Update Rust binaries installed with cargo-liner"
#MISE quiet=true
#MISE interactive=true

set -euo pipefail

backup=$(mktemp)

if [[ -f ~/.cargo/liner.toml ]]; then
  cp ~/.cargo/liner.toml "${backup}"
else
  rm "${backup}"
fi

cargo liner import --force -qq

sed -E -e 's/= "([^"]+)"/= { version = "\1", locked = true }/g' \
  -e 's/\^//g' \
  ~/.cargo/liner.toml | sponge ~/.cargo/liner.toml

vimdiff ~/.cargo/liner.toml home/private_dot_cargo/liner.toml.tmpl

[[ -f "${backup}" ]] && mv "${backup}" ~/.cargo/liner.toml
