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
_relative() { completions_one_command -f; }

complete -F _relative relative
