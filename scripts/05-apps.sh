#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# Apps installed from DMGs outside Homebrew.

install_dmg() {
  local name=$1 url=$2
  local tmp_dmg mount_point app
  tmp_dmg=$(mktemp "/tmp/${name}.XXXXXX.dmg")
  curl -fsSL "$url" -o "$tmp_dmg"
  mount_point=$(hdiutil attach "$tmp_dmg" -nobrowse -quiet | tail -1 | awk '{print $NF}')
  app=$(find "$mount_point" -maxdepth 1 -name "*.app" | head -1)
  if [[ -z "$app" ]]; then
    echo "Warning: No .app found in $name .dmg."
  else
    cp -r "$app" /Applications/
    echo "Installed."
  fi
  hdiutil detach "$mount_point" -quiet
  rm -f "$tmp_dmg"
}

log "UTM"
if [[ ! -d "/Applications/UTM.app" ]]; then
  install_dmg utm "https://github.com/utmapp/UTM/releases/latest/download/UTM.dmg"
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
    install_dmg podscape "$PODSCAPE_URL"
  fi
else
  echo "Already installed."
fi
