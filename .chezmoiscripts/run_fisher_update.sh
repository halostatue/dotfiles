#!/usr/bin/env bash

set -ueo pipefail

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*fisher-update* | true | '*' | 1) exit ;;
esac

home_path="${CHEZMOI_HOME_DIR}"
readonly home_path

declare cache_path config_path
cache_path="${XDG_CACHE_HOME:-"${home_path}/.cache"}"
config_path="${XDG_CONFIG_HOME:-"${home_path}/.config"}"

declare digest_path digest_file stored_digest
digest_path="${cache_path}/chezmoi/install"
digest_file="${digest_path}/fish_plugins.digest"
stored_digest=

[[ -d "${digest_path}" ]] || mkdir -p "${digest_path}"
[[ -f "${digest_file}" ]] && stored_digest="$(cat "${digest_file}")"

declare fish_plugins current_digest

fish_plugins="${config_path}/fish/fish_plugins"

if ! [[ -f "${fish_plugins}" ]]; then
  echo >&2 "No fish_plugins found."
  exit 0
fi

current_digest="$(openssl dgst -sha256 "${fish_plugins}")"

if [[ "${stored_digest}" != "${current_digest}" ]]; then
  fish -c "fisher update"
  echo "${current_digest}" >"${digest_file}"
fi