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
# shellcheck disable=SC2046
_home() { bash4_completions_one_command $(usernames); }

complete -F _home home
