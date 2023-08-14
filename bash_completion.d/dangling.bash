# shellcheck shell=bash

#######################################
# completions for dangling
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_dangling() { completions_one_command -d; }

complete -F _dangling dangling
