#!/usr/bin/env bash

set -euo pipefail

echo run_once_before_1-prepare-system.sh

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*prepare-system* | true | '*' | 1) exit ;;
esac

case "$(uname -s)" in
Darwin)
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
