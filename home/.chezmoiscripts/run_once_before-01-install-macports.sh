#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_once_before_01-install-macports.sh
  exit ${status}
}

trap on-ERR ERR

if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
  echo 01: Install MacPorts

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

case "$(uname -s)" in
Darwin)
  tmp="$(mktemp -d)"
  readonly tmp

  if ! command -v port >/dev/null 2>&1; then
    declare MACPORTS_VERSION os_version url
    MACPORTS_VERSION=2.10.1

    os_version="$(sw_vers -productVersion)"

    case "${os_version}" in
    10.5 | 10.5.*) os_version="10.5-Leopard" ;;
    10.6 | 10.6.*) os_version="10.6-SnowLeopard" ;;
    10.7 | 10.7.*) os_version="10.7-Lion" ;;
    10.8 | 10.8.*) os_version="10.8-MountainLion" ;;
    10.9 | 10.9.*) os_version="10.9-Mavericks" ;;
    10.10 | 10.10.*) os_version="10.10-Yosemite" ;;
    10.11 | 10.11.*) os_version="10.11-ElCapitan" ;;
    10.12 | 10.12.*) os_version="10.12-Sierra" ;;
    10.13 | 10.13.*) os_version="10.13-HighSierra" ;;
    10.14 | 10.14.*) os_version="10.14-Mojave" ;;
    10.15 | 10.15.*) os_version="10.15-Catalina" ;;
    10.16 | 10.16.* | 11 | 11.*) os_version="11-BigSur" ;;
    12 | 12.*) os_version="12-Monterey" ;;
    13 | 13.*) os_version="13-Ventura" ;;
    14 | 14.*) os_version="14-Sonoma" ;;
    15 | 15.*) os_version="15-Sequoia" ;;
    *)
      echo >&2 "OS Version ${os_version} is not yet supported."
      exit 1
      ;;
    esac

    url="$(
      printf "https://github.com/macports/macports-base/releases/download/v%s/MacPorts-%s-%s.pkg" \
        "${MACPORTS_VERSION}" "${MACPORTS_VERSION}" "${os_version}"
    )" || exit 1

    (
      set -e
      cd "${tmp}"
      curl "${url}" -o MacPorts.pkg
      sudo installer -pkg MacPorts.pkg -target /
    )
  fi

  if ! grep -q "file://${HOME}/ports" /opt/local/etc/macports/sources.conf; then
    if ! [[ -d "${HOME}/ports/.git" ]]; then
      if [[ "${CHEZMOI_VERBOSE:-}" == 1 ]]; then
        git clone https://github.com/halostatue/ports.git "${HOME}/ports"
      else
        git clone https://github.com/halostatue/ports.git "${HOME}/ports" >/dev/null 2>/dev/null
      fi
    fi

    sudo sed -i '' -e "/rsync:\\/\\/rsync.macports.org/i\\
file://${HOME}/ports" /opt/local/etc/macports/sources.conf
  fi
  ;;

*) : ;;
esac
