# shellcheck shell=bash

#######################################
# completions for home
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_home() { completions_one_command $(usernames); }

complete -F _home home
