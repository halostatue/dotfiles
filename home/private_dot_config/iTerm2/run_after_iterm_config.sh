#!/usr/bin/env bash

set -euo pipefail

run() {
  # iTerm2 can use a custom prefs folder. Make it use it.
  declare folder load

  if ! folder=$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null); then
    folder=''
  fi

  if [[ -z "${folder}" ]]; then
    folder='{{ joinPath .chezmoi.homeDir ".config/iTerm2" }}'
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${folder}"
  fi

  if ! load=$(defaults read com.googlecode.iterm2 LoadPrefsFromCustomFolder 2>/dev/null); then
    load=false
  fi

  if [[ "${load}" == false ]]; then
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  fi
}

exit 0
