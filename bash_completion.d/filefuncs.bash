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
_filefuncs() { completions_one_command -f; }

complete -F _filefuncs filefuncs
