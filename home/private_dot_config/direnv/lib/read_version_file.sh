# vim: ft=bash

read_version_file() {
  local file
  file="$(find_up_ "$@")"

  [[ -z "${file}" ]] && return

  watch_file "${file}"
  ruby -e "puts ARGF.readline" "${file}" 2>/dev/null
}
