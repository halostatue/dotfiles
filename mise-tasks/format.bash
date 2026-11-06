#!/usr/bin/env bash
#MISE description="Format supported files"
#MISE quiet=true

set -uo pipefail

biome() {
  command npx --yes @biomejs/biome@2 "$@"
}

mapfile -t managed < <(chezmoi managed --path-style source-absolute || true)

find_files() {
  local ext shebang
  ext="${1}"
  shebang="${2}"
  shift 2

  {
    [[ -n "${ext}" ]] && fd -H -e "${ext}"
    [[ -n "${shebang}" ]] && rg -l -m1 "${shebang}" "${managed[@]}" 2>/dev/null
    (($#)) && printf '%s\n' "$@"
  } | sort -u
}

biome migrate --config-path=biome.json --write
biome check --config-path=biome.json --write biome.json
biome check --config-path=biome.json --fix --stdin-file-path=~/.finicky.ts \
  <home/private_dot_finicky.ts.tmpl |
  sponge home/private_dot_finicky.ts.tmpl

find_files sh.tmpl '' lib/lib.bash | xargs shfmt -w
# find_files '' '^#!.*\bbash' | xargs shfmt -w

mapfile -t pythons < <(find_files py '^#!.*\bpython\d?' home/private_dot_pythonrc || true)

ruff check --fix "${pythons[@]}"

mapfile -t rubies < <(find_files rb '^#!.*ruby' lib/update.rb || true)

standardrb --fix "${rubies[@]}"
