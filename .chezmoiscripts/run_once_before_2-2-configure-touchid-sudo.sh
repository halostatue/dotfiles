#!/usr/bin/env bash

set -euo pipefail

echo run_once_before_2-2-configure-touchid-sudo.sh

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*configure-touchid-sudo* | true | '*' | 1) exit ;;
esac

case "$(uname -s)" in
Darwin)
  if ! grep -q pam_tid.so /etc/pam.d/sudo; then
    osascript -e 'tell application "System Preferences" to quit'
    sudo sed -i '' -e '2i\
auth       sufficient     pam_tid.so' /etc/pam.d/sudo
  fi
  ;;
esac
