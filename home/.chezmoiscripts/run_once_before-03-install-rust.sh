#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_once_before_03-install-rust.sh
  exit ${status}
}

trap on-ERR ERR

if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
  echo 03: Install Rust

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

if ! command -v rustup >/dev/null 2>/dev/null || ! [[ -x "${HOME}/.cargo/bin/rustup" ]]; then
  if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh >/dev/null 2>/dev/null
  fi

  # shellcheck disable=SC1091
  source "${HOME}"/.cargo/env
fi

declare flags
flags=(--force)

if ! [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
  flags=(--quiet)
fi

# Install cargo-binstall and cargo-install-update since they will be used for the regular updates.
if ! command -v cargo-binstall >/dev/null 2>/dev/null; then
  cargo install "${flags[@]}" cargo-binstall
fi

if ! command -v cargo-install-update >/dev/null 2>/dev/null; then
  cargo install "${flags[@]}" cargo-install-update
fi
