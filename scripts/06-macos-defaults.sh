#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# macOS system preferences.

log "App Switcher on all displays"
defaults write com.apple.dock appswitcher-all-displays -bool true
killall Dock
echo "Done."
