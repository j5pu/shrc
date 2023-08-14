# shellcheck shell=bash

#######################################
# completions for shrc
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_shrc() {  completions_one_command all clean install uninstall; }

complete -F _shrc shrc
