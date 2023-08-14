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
_usernames() { completions_one_command; }

complete -F _usernames usernames
