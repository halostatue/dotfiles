#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_once_before_00-prepare-system.sh
  exit ${status}
}

trap on-ERR ERR

if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
  echo 00: prepare system

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

case "$(uname -s)" in
Darwin)
  declare license arch xcode_path
  arch="$(uname -m)"

  # Install Rosetta on an Apple Silicon mac
  if [[ "${arch}" == arm64 ]] && ! [[ -f /Library/Apple/usr/share/rosetta/rosetta ]]; then
    softwareupdate --install-rosetta --agree-to-license
  fi

  license="$(defaults read /Library/Preferences/com.apple.dt.Xcode | awk '/IDELastGMLicenseAgreedTo/ { print $3; }' | sed 's/;//')"
  if [[ -z "${license}" ]]; then
    sudo xcodebuild -license
  fi

  xcode_path="$(xcode-select --print-path)"

  if [[ -z "${xcode_path}" ]]; then
    xcode-select --install
  fi
  ;;

*) : ;;
esac
