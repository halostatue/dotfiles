# vim: ft=bash

use_kx() {
  has kx || return

  local version
  version="$1"

  [[ "${version}" == --auto ]] && version="$(read_version_file .elixir-version)"
  [[ -z "${version}" ]] && return

  local matching_version
  matching_version="$(
    kx list installed --elixir "${version}" --short | awk "{ print \$1 }" | sort -ru | head -1
  )"

  if [[ -z "${matching_version}" ]]; then
    echo "Error: Missing elixir version: $version. Install using kx." 1>&2
    return 1
  fi

  local activate
  # direnv _always_ works with bash
  activate="$(USERSHELL=bash kx source ${matching_version})" || {
    echo >&2 "Error: Missing elixir version: $version. Install using kx."
    return 1
  }

  [[ -f "${activate}" ]] && unsafe source "${activate}"
}
