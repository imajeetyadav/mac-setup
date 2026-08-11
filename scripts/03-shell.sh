#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# Zsh environment: Oh My Zsh, Powerlevel10k + fonts, plugins, and ~/.zshrc.

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
if ! cmp -s "$REPO_DIR/zshrc" "$HOME/.zshrc" 2>/dev/null; then
  if [[ -f "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup-$(date +%Y-%m-%d-%H%M%S)"
    echo "Backed up existing ~/.zshrc"
  fi
  cp "$REPO_DIR/zshrc" "$HOME/.zshrc"
  echo "Installed ~/.zshrc from repo."
else
  echo "Already up to date."
fi
