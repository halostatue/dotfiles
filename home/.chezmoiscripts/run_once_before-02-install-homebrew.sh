#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_once_before_02-install-homebrew.sh
  exit ${status}
}

trap on-ERR ERR

if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
  echo 02: Install Homebrew

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
    declare installer
    installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
      /bin/bash -c "${installer}"
    else
      /bin/bash -c "${installer}" >/dev/null 2>/dev/null
    fi
  fi

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
  chmod -R go-w "$(brew --prefix)/share" || true
  ;;

*) : ;;
esac
