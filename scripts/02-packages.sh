#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# All Homebrew formulae, casks, and VS Code extensions from the Brewfile.

log "Brew Bundle"
brew update
brew bundle --file="$REPO_DIR/Brewfile"
