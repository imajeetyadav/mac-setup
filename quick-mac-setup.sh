#!/bin/bash
set -euo pipefail

# Mac M4 setup script — safe to run on a new Mac or re-run on an existing one.

# ── Helpers ───────────────────────────────────────────────────────────────────
log() { echo ""; echo "══ $* ══"; }

clone_or_pull() {
  local repo=$1 dest=$2
  if [[ ! -d "$dest" ]]; then
    git clone --depth=1 "$repo" "$dest"
  else
    git -C "$dest" pull --ff-only
  fi
}

# ── Prerequisites ─────────────────────────────────────────────────────────────
log "Xcode Command Line Tools"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Re-run this script after Xcode CLI tools finish installing."
  exit 0
else
  echo "Already installed."
fi

log "Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
else
  echo "Already installed."
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── Packages ──────────────────────────────────────────────────────────────────
log "Brew Bundle"
brew update
brew bundle --file="$(dirname "$0")/Brewfile"

# ── Shell Environment ─────────────────────────────────────────────────────────
log "Oh My Zsh"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Already installed."
fi

log "Default Shell"
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  chsh -s "$(command -v zsh)"
else
  echo "Already zsh."
fi

log "Powerlevel10k"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_or_pull https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"

log "MesloLGS NF Font (for Powerlevel10k icons)"
# Set this font in your terminal profile (iTerm2/Terminal: Profiles -> Text -> Font)
for style in "Regular" "Bold" "Italic" "Bold Italic"; do
  font="MesloLGS NF ${style}.ttf"
  if [[ ! -f "$HOME/Library/Fonts/$font" ]]; then
    curl -fsSL "https://github.com/romkatv/powerlevel10k-media/raw/master/${font// /%20}" \
      -o "$HOME/Library/Fonts/$font"
    echo "Installed: $font"
  else
    echo "Already installed: $font"
  fi
done

log "Zsh Plugins"
clone_or_pull https://github.com/zsh-users/zsh-autosuggestions              "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_or_pull https://github.com/zsh-users/zsh-completions                  "$ZSH_CUSTOM/plugins/zsh-completions"
clone_or_pull https://github.com/zsh-users/zsh-history-substring-search     "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
clone_or_pull https://github.com/zdharma-continuum/fast-syntax-highlighting  "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
clone_or_pull https://github.com/djui/alias-tips                             "$ZSH_CUSTOM/plugins/alias-tips"
clone_or_pull https://github.com/MichaelAquilina/zsh-you-should-use          "$ZSH_CUSTOM/plugins/you-should-use"

log "Zsh Config"
if ! cmp -s "$(dirname "$0")/zshrc" "$HOME/.zshrc" 2>/dev/null; then
  if [[ -f "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup-$(date +%Y-%m-%d-%H%M%S)"
    echo "Backed up existing ~/.zshrc"
  fi
  cp "$(dirname "$0")/zshrc" "$HOME/.zshrc"
  echo "Installed ~/.zshrc from repo."
else
  echo "Already up to date."
fi

# ── Version Managers ──────────────────────────────────────────────────────────
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

# ── Manual Installs ───────────────────────────────────────────────────────────
log "UTM"
if [[ ! -d "/Applications/UTM.app" ]]; then
  TMP_DMG=$(mktemp /tmp/utm.XXXXXX.dmg)
  trap 'rm -f "$TMP_DMG"' EXIT
  curl -fsSL "https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg" -o "$TMP_DMG"
  MOUNT_POINT=$(hdiutil attach "$TMP_DMG" -nobrowse -quiet | tail -1 | awk '{print $NF}')
  APP=$(find "$MOUNT_POINT" -maxdepth 1 -name "*.app" | head -1)
  if [[ -z "$APP" ]]; then
    echo "Warning: No .app found in UTM .dmg."
  else
    cp -r "$APP" /Applications/
    echo "Installed."
  fi
  hdiutil detach "$MOUNT_POINT" -quiet
  rm "$TMP_DMG"
else
  echo "Already installed."
fi

log "Podscape"
if [[ ! -d "/Applications/Podscape.app" ]]; then
  PODSCAPE_URL=$(curl -fsSL https://api.github.com/repos/codingprotocols/podscape/releases/latest \
    | jq -r '.assets[] | select(.name | test("\\.dmg$"; "i")) | .browser_download_url' \
    | head -1)
  if [[ -z "$PODSCAPE_URL" ]]; then
    echo "Warning: Could not find Podscape .dmg. Check https://github.com/codingprotocols/podscape/releases"
  else
    TMP_DMG=$(mktemp /tmp/podscape.XXXXXX.dmg)
    trap 'rm -f "$TMP_DMG"' EXIT
    curl -fsSL "$PODSCAPE_URL" -o "$TMP_DMG"
    MOUNT_POINT=$(hdiutil attach "$TMP_DMG" -nobrowse -quiet | tail -1 | awk '{print $NF}')
    APP=$(find "$MOUNT_POINT" -maxdepth 1 -name "*.app" | head -1)
    if [[ -z "$APP" ]]; then
      echo "Warning: No .app found in Podscape .dmg."
    else
      cp -r "$APP" /Applications/
      echo "Installed."
    fi
    hdiutil detach "$MOUNT_POINT" -quiet
    rm "$TMP_DMG"
  fi
else
  echo "Already installed."
fi

log "Done"
echo "Open a new terminal for all changes to take effect."
