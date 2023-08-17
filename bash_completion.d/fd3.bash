# shellcheck shell=bash

#######################################
# completions for fd3
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_fd3() { bash4_completions_one_command; }

complete -F _fd3 fd3
