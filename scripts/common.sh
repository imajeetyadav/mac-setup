#!/bin/bash
# Shared helpers — sourced by every stage script. Not meant to be run directly.

log() { echo ""; echo "══ $* ══"; }

clone_or_pull() {
  local repo=$1 dest=$2
  if [[ ! -d "$dest" ]]; then
    git clone --depth=1 "$repo" "$dest"
  else
    git -C "$dest" pull --ff-only
  fi
}

# Repo root (scripts live in scripts/, Brewfile and zshrc at the root)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[1]}")/.." && pwd)"

# Make brew available when a stage is run standalone
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
