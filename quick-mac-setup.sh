#!/bin/bash
set -euo pipefail

# Mac M4 setup — runs all stages in order. Safe to run on a fresh Mac or
# re-run on an existing one (every stage is idempotent).
#
# Run everything:       bash quick-mac-setup.sh
# Run a single stage:   bash scripts/03-shell.sh
#
# Stages:
#   01-prerequisites     Xcode CLI Tools + Homebrew
#   02-packages          Brewfile (formulae, casks, VS Code extensions)
#   03-shell             Oh My Zsh, Powerlevel10k + fonts, plugins, ~/.zshrc
#   04-version-managers  NVM/Node, SDKMAN/Java, FVM/Flutter, tfenv/Terraform
#   05-apps              DMG installs (UTM, Podscape)
#   06-macos-defaults    macOS system preferences

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for stage in "$SCRIPT_DIR"/scripts/[0-9]*.sh; do
  bash "$stage"
done

echo ""
echo "All done. Open a new terminal for changes to take effect."
