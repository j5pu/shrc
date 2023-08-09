# shellcheck shell=bash

#######################################
# iphotos_completion
# Globals:
#   COMPREPLY
#   COMP_CWORD
#   COMP_WORDS
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
_iphotos_completion() {
    local IFS=$'
'
    # shellcheck disable=SC2207,SC2086
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _IPHOTOS_COMPLETE=complete_bash $1 | sed 's/plain,//g') )
    return 0
}

complete -o default -F _iphotos_completion iphotos
