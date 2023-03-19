#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_once_before_0-prepare-system.sh
  exit ${status}
}

trap on-ERR ERR

declare verbose
verbose="${CHEZMOI_VERBOSE:-false}"

if "${verbose}"; then
  echo 0: prepare system

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

case "$(uname -s)" in
Darwin)
  declare license

  # Install Rosetta on an Apple Silicon mac
  if [[ "$(uname -m)" == arm64 ]] && ! [[ -f /Library/Apple/usr/share/rosetta/rosetta ]]; then
    softwareupdate --install-rosetta --agree-to-license
  fi

  license="$(defaults read /Library/Preferences/com.apple.dt.Xcode | awk '/IDELastGMLicenseAgreedTo/ { print $3; }' | sed 's/;//')"
  if [[ -z "${license}" ]]; then
    sudo xcodebuild -license
  fi

  if [[ -z "$(xcode-select --print-path)" ]]; then
    xcode-select --install
  fi
  ;;
esac
