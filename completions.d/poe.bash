# shellcheck shell=bash

#######################################
# description
# Globals:
#   COMPREPLY
#   COMP_CWORD
#   COMP_WORDS
# Arguments:
#  None
# Returns:
#   0 ...
#######################################
_poe_complete() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    # shellcheck disable=SC2207,SC2086
    COMPREPLY=( $(compgen -W "$(poe _list_tasks)" -- ${cur}) )
    return 0
}
complete -o default -F _poe_complete poe
