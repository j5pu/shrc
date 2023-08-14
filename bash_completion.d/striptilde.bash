# shellcheck shell=bash

#######################################
# completions for striptilde
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_striptilde() { completions_one_command; }

complete -F _striptilde striptilde
