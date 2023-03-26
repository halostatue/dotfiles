#!/usr/bin/env bash

set -uo pipefail

on-ERR() {
  local status=$?
  echo >&2 Error executing run_onchange_after_configure-apps.sh
  exit ${status}
}

trap on-ERR ERR

declare verbose
verbose=false
[[ "${CHEZMOI_VERBOSE:-}" == 1 ]] && verbose=true

if "${verbose}"; then
  echo Configure Apps

  if "${DEBUG_SCRIPTS:-false}"; then
    set -x
  fi
fi

case "$(uname -s)" in
Darwin)
  osascript -e 'tell application "System Preferences" to quit'

  # GPG settings
  gpg-connect-agent reloadagent /bye

  # Finder settings
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.Finder AppleShowAllFiles -bool true
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.finder FXDefaultSearchScope -string SCcf
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
  defaults write com.apple.finder QLEnableTextSelection -bool true
  defaults write com.apple.finder SearchRecentsSavedViewStyle -string Nlsv
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true

  # Software Update settings
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
  sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
  defaults write com.apple.commerce AutoUpdate -bool true

  # Make Safari’s search banners default to Contains instead of Starts With
  defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

  # Add a context menu item for showing the Web Inspector in web views
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  # Dock settings
  defaults write com.apple.dock launchanim -bool true
  defaults write com.apple.dock minimize-to-application -bool true
  defaults write com.apple.dock orientation -string left
  defaults write com.apple.dock show-process-indicators -bool true
  defaults write com.apple.dock showhidden -bool true
  defaults write com.apple.dock tilesize -int 43
  # https://www.defaults-write.com/enable-spring-loaded-dock-items/
  defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

  # TextEdit settings
  # Set default TextEdit document format as plain text
  defaults write com.apple.TextEdit RichText -bool false
  # Open and save files as UTF-8
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

  # Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # Automatically quit printer app once the print jobs complete
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  # Do not restore previously-opened windows in Preview
  # https://apple.stackexchange.com/questions/54854/is-there-a-way-to-make-preview-not-open-all-previously-opened-files
  defaults write com.apple.Preview ApplePersistenceIgnoreState YES

  # Turn off two-finger swipe to go left on Chrome. Just scroll left and stop.
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

  # Show item info below desktop icons ("5 items" for folders)
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

  # Enable snap-to-grid for desktop icons
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

  # Kill affected applications
  for app in Finder Dock TextEdit SystemUIServer; do
    killall "$app" >/dev/null 2>&1 || true
  done

  for app in Safari Mail; do
    killall "$app" >/dev/null 2>&1 || true
  done
  ;;
esac

# Make chezmoi use Git with SSH
(
  set -e
  cd "${CHEZMOI_WORKING_TREE}"
  declare CHEZMOI_SSH_URL
  CHEZMOI_SSH_URL="$(git remote get-url origin | sed -Ene's#https://([^/]*)/([^/]*/.*.git)#git@\1:\2#p')"
  [[ -z ${CHEZMOI_SSH_URL} ]] || git remote set-url origin "${CHEZMOI_SSH_URL}"
)
