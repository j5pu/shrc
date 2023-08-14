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
_fd3() { completions_one_command; }

complete -F _fd3 fd3
