#!/usr/bin/env bash

set -euo pipefail

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*configure-touchid-sudo* | true | '*' | 1) exit ;;
esac

case "$(uname -s)" in
Darwin)
  osascript -e 'tell application "System Preferences" to quit'

  grep -q pam_tid.so /etc/pam.d/sudo || sudo sed -i '' -e '2i\
auth       sufficient     pam_tid.so' /etc/pam.d/sudo
  ;;
esac
