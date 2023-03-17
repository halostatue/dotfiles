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
  defaults write com.apple.dock launchanim -bool true
  defaults write com.apple.dock minimize-to-application -bool true
  defaults write com.apple.dock orientation -string left
  defaults write com.apple.dock show-process-indicators -bool true
  defaults write com.apple.dock showhidden -bool true
  defaults write com.apple.dock tilesize -int 43
  # https://www.defaults-write.com/enable-spring-loaded-dock-items/
  defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

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

  # Show item info below desktop icons ("5 items" for folders)
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

  # Enable snap-to-grid for desktop icons
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

  # https://www.howtogeek.com/261880/how-to-show-the-expanded-print-and-save-dialogs-in-os-x-by-default/
  # When saving a document, show full Finder to choose where to save it
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  # Expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

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

  # Do not restore previously-opened windows in Preview
  # https://apple.stackexchange.com/questions/54854/is-there-a-way-to-make-preview-not-open-all-previously-opened-files
  defaults write com.apple.Preview ApplePersistenceIgnoreState YES

  # Turn off two-finger swipe to go left on Chrome. Just scroll left and stop.
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

  # Kill affected applications
  for app in Safari Finder Dock Mail SystemUIServer; do
    killall "$app" >/dev/null 2>&1
  done
  ;;
esac
