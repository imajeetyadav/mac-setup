#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# Language/version managers: NVM (Node), SDKMAN (Java), FVM (Flutter), tfenv (Terraform).
# FVM and tfenv come from the Brewfile — run 02-packages.sh first.

log "NVM + Node"
export NVM_DIR="$HOME/.nvm"
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
fi
source "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

log "SDKMAN + Java"
if [[ ! -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  curl -s "https://get.sdkman.io" | bash
fi
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 21.0.7-tem || true

log "FVM + Flutter"
fvm install stable
fvm global stable

log "tfenv + Terraform"
tfenv install latest
tfenv use latest
