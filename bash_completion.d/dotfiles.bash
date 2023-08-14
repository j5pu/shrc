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
_dotfiles() { completions_one_command -d; }

complete -F _dotfiles dotfiles
