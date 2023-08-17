# shellcheck shell=bash

#######################################
# completions for usernames
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_usernames() { bash4_completions_one_command; }

complete -F _usernames usernames
