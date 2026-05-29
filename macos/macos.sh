#!/usr/bin/env bash

# @see: https://github.com/mathiasbynens/dotfiles/blob/main/.macos

set -euo pipefail

# Close any open System Settings panes to prevent them overriding our changes.
osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront.
sudo -v

# Keep sudo alive until the script finishes.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Expand save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# Trackpad, Keyboard and Input                                                #
###############################################################################

# Enable tap to click for this user and for the login screen.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins.
defaults write com.apple.screensaver askForPassword -int 1

###############################################################################
# Finder                                                                      #
###############################################################################

# Show path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Use icon view in all Finder windows by default.
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# Keep folders on top when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Keep folders on top when sorting by name on the desktop.
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Search the current folder by default.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Open new windows to the home folder.
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show external drives and removable media on the desktop, but not internal drives or servers.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# Enable spring loading for directories and reduce the default delay (default: 0.5).
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.3

# Show the ~/Library folder.
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library 2>/dev/null || true

# Show the /Volumes folder.
sudo chflags nohidden /Volumes

###############################################################################
# Dock                                                                        #
###############################################################################

# Use the scale effect when minimising windows.
defaults write com.apple.dock mineffect -string "scale"

# Minimise windows into their application's icon.
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications.
defaults write com.apple.dock show-process-indicators -bool true

# Don't automatically rearrange Spaces based on most recent use.
defaults write com.apple.dock mru-spaces -bool false

# Don't show recent applications in the Dock.
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume.
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor.
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Sort results by CPU usage.
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# TextEdit                                                                    #
###############################################################################

# Use plain text mode for new documents.
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Software Update                                                             #
###############################################################################

# Enable the automatic update check.
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in the background.
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install system data files and security updates.
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Google Chrome                                                               #
###############################################################################

# Disable the over-sensitive backswipe on trackpads and Magic Mouse.
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog.
# defaults write com.google.Chrome DisablePrintPreview -bool true

# Expand the print dialog by default.
# defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Transmission                                                                #
###############################################################################

# Use ~/Torrents to store completed downloads, creating the directory if needed.
mkdir -p "${HOME}/Torrents"
defaults write org.m0k.transmission DownloadFolder -string "${HOME}/Torrents"
defaults write org.m0k.transmission DownloadLocationConstant -bool true

# Don't prompt for confirmation before downloading.
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Hide the donate message and legal disclaimer.
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false

###############################################################################
# Restart affected applications                                               #
###############################################################################

for app in \
    "Activity Monitor" \
    "cfprefsd" \
    "Dock" \
    "Finder" \
    "Google Chrome" \
    "Photos" \
    "SystemUIServer" \
    "Terminal" \
    "Transmission"; do
    killall "${app}" &>/dev/null || true
done

echo "Done. Some changes require a logout or restart to take effect."
