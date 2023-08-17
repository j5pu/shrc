# shellcheck shell=bash

#######################################
# completions for dangling-rm
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_dangling_rm() { bash4_completions_one_command -d; }

complete -F _dangling_rm dangling-rm
