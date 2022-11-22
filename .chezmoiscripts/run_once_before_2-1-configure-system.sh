#!/usr/bin/env bash

set -euo pipefail

echo run_once_before_2-1-configure-system.sh

case "${CHEZMOI_SKIP_SCRIPTS:-}" in
*configure-system* | true | '*' | 1) exit ;;
esac

case "$(uname -s)" in
Darwin)
  osascript -e 'tell application "System Preferences" to quit'

  # Dock settings
  defaults write com.apple.dock orientation -string "right"
  defaults write com.apple.dock "tilesize" -int 43
  defaults write com.apple.dock minimize-to-application -bool true
  defaults write com.apple.dock launchanim -bool true
  defaults write com.apple.dock show-process-indicators -bool true
  killall Dock

  # Finder settings
  defaults write com.apple.Finder "AppleShowAllFiles" -bool "true"
  defaults write com.apple.finder QLEnableTextSelection -bool true
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
  defaults write com.apple.finder SearchRecentsSavedViewStyle -string "Nlsv"
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  killall Finder

  # Software Update settings
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
  defaults write com.apple.commerce AutoUpdate -bool true
  ;;
esac
