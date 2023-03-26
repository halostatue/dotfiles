#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_once_before_install-2-homebrew.sh
  exit ${status}
}

trap on-ERR ERR

declare verbose
verbose=false
[[ "${CHEZMOI_VERBOSE:-}" == 1 ]] && verbose=true

if "${verbose}"; then
  echo 2: Install Homebrew

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

set -euo pipefail

case "$(uname -s)" in
Darwin)
  if command -v brew >/dev/null 2>/dev/null; then
    exit 0
  fi

  case "$(uname -m)" in
  arm64) HOMEBREW_PREFIX="/opt/homebrew" ;;
  *) HOMEBREW_PREFIX="/usr/local" ;;
  esac

  if ! [[ -x "${HOMEBREW_PREFIX}"/bin/brew ]]; then
    if [[ "${verbose}" ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
        >/dev/null 2>/dev/null
    fi
  fi

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
  chmod -R go-w "$(brew --prefix)/share"
  ;;
esac
