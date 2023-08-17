# vim: ft=bash

use_kiex() {
  has kiex || return

  local version
  version="$1"

  [[ "${version}" == --auto ]] && version="$(read_version_file .elixir-version)"
  [[ -z "${version}" ]] && return

  local version_path
  version_path=$(
    kiex list |
      ruby -e "puts ARGF.read.scan(/elixir-${version}.*/).last"
  )

  if [[ -z "${version_path}" ]]; then
    echo "Error: Missing elixir version: ${version}. Install using kiex." 1>&2
    return 1
  fi

  local activate
  activate="${KIEX_HOME:-${HOME}/.kiex}/elixirs/${version_path}.env"

  [[ -f "${activate}" ]] && unsafe source "${activate}"
}
