# shellcheck shell=bash

#######################################
# check if key in array and shows value or nothing with no errors
# Globals:
#   _ARRAY
# Arguments:
#   key         the value to search
#   [array]     array name (default: COMP_WORDS)
# Returns:
#   1 if value not in array, or invalid array
#######################################
array_default() {
  cparray "${2-}" || return 1
  printf '%s' "${_ARRAY["${1}"]-}" 2>/dev/null || true
}
