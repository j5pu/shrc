# shellcheck shell=bash

#######################################
# completions for filefuncs
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_filefuncs() { bash4_completions_one_command -f; }

complete -F _filefuncs filefuncs
