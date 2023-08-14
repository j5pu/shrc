# shellcheck shell=bash

#######################################
# completions for dangling
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
# shellcheck disable=SC2046
_funcexported() { completions_one_command $(declare -pFx | awk '{ print $3 }'); }

complete -F _funcexported funcexported
