# shellcheck shell=bash

#######################################
# hascmd
# Globals:
#   COMPREPLY
# Arguments:
#   1     name of the command whose arguments are being completed
#   2     word being completed ("cur")
#   3     word preceding the word being completed or $1 when is the first word ("prev")
#######################################
_hascmd() {
  [ "$1" = "$3" ] || return 0
  mapfile -t COMPREPLY < <(compgen -c -o nospace -W "-h --help help" -- "$2")
}

complete -F _hascmd hascmd
