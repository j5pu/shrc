# shellcheck shell=bash

#######################################
# completions for relative
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_relative() { bash4_completions_one_command -f; }

complete -F _relative relative
