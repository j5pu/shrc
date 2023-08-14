# shellcheck shell=bash

#######################################
# inargs pwd_p
# Globals:
#   COMPREPLY
# Arguments:
#   1     name of the command whose arguments are being completed
#   2     word being completed ("cur")
#   3     word preceding the word being completed or $1 when is the first word ("prev")
#######################################
_pwd_p() { completions_one_command -f; }

complete -F _pwd_p pwd_p
