#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_after_fisher-update.sh
  exit ${status}
}

trap on-ERR ERR

declare verbose
verbose="${CHEZMOI_VERBOSE:-false}"

if "${verbose}"; then
  echo Update fisher packages

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

# Make sure that we have fish and fisher
if ! command -v fish >/dev/null 2>&1; then
  if "${verbose}"; then
    echo >&2 "fish is not installed"
    exit 1
  fi

  exit 0
fi

if ! fish -c "functions --query fisher"; then
  if "${verbose}"; then
    echo >&2 "fisher is not installed"
    exit 1
  fi

  exit 0
fi

declare cache_path config_path digest_path digest_file stored_digest fish_plugins current_digest
cache_path="${XDG_CACHE_HOME:-"${CHEZMOI_HOME_DIR}/.cache"}"
config_path="${XDG_CONFIG_HOME:-"${CHEZMOI_HOME_DIR}/.config"}"
fish_plugins="${config_path}/fish/fish_plugins"

digest_path="${cache_path}/chezmoi/install"
digest_file="${digest_path}/fish_plugins.digest"
stored_digest=

if ! [[ -f "${fish_plugins}" ]]; then
  if "${verbose}"; then
    echo >&2 "No fish_plugins found."
    exit 1
  fi

  exit 0
fi

[[ -d "${digest_path}" ]] || mkdir -p "${digest_path}"
if [[ -f "${digest_file}" ]]; then
  stored_digest="$(cat "${digest_file}")"
fi

current_digest="$(openssl dgst -sha256 "${fish_plugins}")"

if [[ "${stored_digest}" != "${current_digest}" ]]; then
  if "${verbose}"; then
    fish -c "fisher update"
  else
    fish -c "fisher update" >/dev/null 2>/dev/null
  fi

  echo "${current_digest}" >"${digest_file}"
elif "${verbose}"; then
  echo fisher packages are up to date
fi
