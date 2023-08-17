# shellcheck shell=bash

#######################################
# inargs ismacos
# Globals:
#   COMPREPLY
# Arguments:
#   1     name of the command whose arguments are being completed
#   2     word being completed ("cur")
#   3     word preceding the word being completed or $1 when is the first word ("prev")
#######################################
_ismacos() { bash4_completions_one_command; }

complete -F _ismacos ismacos
