# shellcheck shell=zsh

#######################################
# bash completions in zsh
# Arguments:
#  None
#######################################
zsh_bashcompinit() { ! has autoload || has bashcompinit || { autoload -U +X bashcompinit && bashcompinit; }; }
