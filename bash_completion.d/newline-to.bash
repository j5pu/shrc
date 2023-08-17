# shellcheck shell=bash

#######################################
# completions for newline-to
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_newline_to() { bash4_completions_one_command; }

complete -F _newline_to newline-to
