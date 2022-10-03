#!/usr/bin/env bash

if [[ "$(uname -s)" == Darwin ]]; then
  osascript -e 'tell application "System Preferences" to quit'

  grep -q pam_tid.so /etc/pam.d/sudo || sudo sed -i '' -e '2i\
auth       sufficient     pam_tid.so' /etc/pam.d/sudo
fi
