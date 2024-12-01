#! /usr/bin/env bash

set -euo pipefail

tmpdiff() {
  local tmpdir tmp target
  target="${1:?}"
  tmpdir="$(mktemp -d)"
  tmp="${tmpdir}/$(basename "${target}" ".tmpl")"
  shift

  on-EXIT() {
    rm -rf "${tmpdir}"
  }

  "$@" >"${tmp}"

  vimdiff "${tmp}" "${target}"
}

read-ports() (
  port echo requested |
    sed -e 's/  */ /' -e 's/\@[^+][^+]*//' -e 's/ $//' -e 's/^/install /' |
    sort --ignore-case --unique

  echo

  port select --summary |
    awk 'NR > 2 && $2 != "none" { print "select --set", $1, $2 }' |
    sort --ignore-case --unique
)

case "${1:?}" in
go) tmpdiff home/private_dot_config/gup/gup.conf.tmpl gup export -o ;;
ports) tmpdiff home/private_dot_config/packages/ports.tmpl read-ports ;;
*) : ;;
esac
