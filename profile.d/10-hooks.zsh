# shellcheck shell=zsh disable=SC2034

zsh_bashcompinit

setopt INTERACTIVE_COMMENTS  # allow inline comments like this one

setopt PROMPT_SUBST

zstyle ':omz:update' mode auto      # update automatically without asking

CASE_SENSITIVE="true"

DISABLE_AUTO_TITLE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  brew colored-man-pages colorize command-not-found
  debian direnv docker docker-compose
  gh git grc httpie iterm2
  keychain macos pip python rsync sudo systemd
  textmate ubuntu ufw urltools
  web-search zsh-interactive-cd zsh-navigation-tools
)

ZSH_DISABLE_COMPFIX="true"

ZSH_THEME="robbyrussell"

export ZSH="${RC_D}/.oh-my-zsh"

source "${ZSH}/oh-my-zsh.sh"

set -y
