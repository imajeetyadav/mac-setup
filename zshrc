##############################################
#  Powerlevel10k Instant Prompt (MUST be top)
##############################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################################
#  Oh My Zsh Setup
##############################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  docker
  extract
  z
  alias-tips
  you-should-use
  zsh-completions
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search  # LAST
)

source $ZSH/oh-my-zsh.sh

##############################################
#  PATH Setup
##############################################
# Preserve existing system PATH, then prepend tool paths
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/opt/php/bin:/opt/homebrew/opt/mysql-client/bin:$PATH"

# Custom Tools
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.docker/bin:$HOME/.lmstudio/bin:$HOME/bin/csvlint:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

##############################################
#  Development Tools
##############################################
# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

##############################################
#  Shell Behavior & History
##############################################
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch arm64"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt SHARE_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS EXTENDED_HISTORY

##############################################
#  Completion & Navigation
##############################################
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt always_to_end
setopt menu_complete
unsetopt flowcontrol
setopt correct
setopt interactive_comments

# Completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive

# Custom fpaths for completions
fpath=(~/.docker/completions $fpath)

# Enable completions
autoload -Uz compinit
compinit

##############################################
#  History-based autocomplete tweaks
##############################################
# Light gray inline suggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Accept autosuggestion with End key (right arrow also works by default)
bindkey '^[[F' autosuggest-accept

# Cycle through matching history with arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Case-insensitive history search
zstyle ':history-substring-search:*' case-sensitive 'false'

##############################################
#  Powerlevel10k Prompt
##############################################
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##############################################
#  Homebrew tweaks
##############################################
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Use ripgrep (rg) instead of find for fzf (faster, respects .gitignore)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set preview window (press Tab in fzf to preview files)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --style=numbers --color=always --line-range :500 {}"'

# Ctrl-R uses fzf for history search
bindkey '^R' fzf-history-widget

##############################################
#  SDKMAN (MUST be at END of file)
##############################################
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
