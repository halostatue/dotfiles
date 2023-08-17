# vim: ft=bash

use_kerl() {
  has kerl || return

  local version
  version="$1"

  [[ "${version}" == --auto ]] && version="$(read_version_file .erlang-version)"
  [[ -z "${version}" ]] && return

  local version_path
  version_path=$(
    kerl list installations |
      ruby -e "puts ARGF.read.scan(/${version}.*/).last&.split&.last"
  )
  if [[ -z "${version_path}" ]]; then
    echo "Error: Missing erlang version: ${version}. Install using kerl." 1>&2
    return 1
  fi

  local activate
  activate="${version_path}/activate"
  [[ -f "${activate}" ]] && unsafe source "${activate}"
}
