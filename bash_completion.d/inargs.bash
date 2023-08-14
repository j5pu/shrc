# shellcheck shell=bash

#######################################
# inargs completions
# Globals:
#   COMPREPLY
# Arguments:
#   1     name of the command whose arguments are being completed
#   2     word being completed ("cur")
#   3     word preceding the word being completed or $1 when is the first word ("prev")
#######################################
_inargs() { return 0; }

complete -F _inargs inargs
