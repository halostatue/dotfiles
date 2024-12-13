# vim: set ft=bash
# shellcheck shell=bash

set -uo pipefail

setup() {
  if (($#)); then
    info "$*"
  fi

  if verbose && [[ "${DEBUG_SCRIPTS:-}" = true ]]; then
    set -x
  fi

  trap on-ERR ERR
}

warn() {
  verbose && echo >&2 "$*"
  true
}

info() {
  verbose && echo "$*"
  true
}

verbose() {
  [[ ${CHEZMOI_VERBOSE:=0} == 1 ]]
}

has() {
  command -v "${1:?}" >/dev/null 2>/dev/null
}

on-ERR() {
  local status=$?
  echo >&2 "Error executing ${script_name:-$(basename "$0")}"
  exit ${status}
}
