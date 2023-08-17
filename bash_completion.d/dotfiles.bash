# shellcheck shell=bash

#######################################
# completions for dotfiles
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_dotfiles() { bash4_completions_one_command -d; }

complete -F _dotfiles dotfiles
