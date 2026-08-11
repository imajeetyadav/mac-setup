#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# Xcode Command Line Tools + Homebrew — everything else depends on these.

log "Xcode Command Line Tools"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Re-run setup after Xcode CLI tools finish installing."
  exit 1
else
  echo "Already installed."
fi

log "Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Already installed."
fi
