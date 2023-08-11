# shellcheck shell=bash


#######################################
# check if value in array exists and return index
# Globals:
#   _ARRAY
# Arguments:
#   value       the value to search
#   [array]     array name (default: COMP_WORDS)
# Returns:
#   1 if value not in array, or invalid array
#######################################
getkey() {
  local index
  cparray "${2-}" || return 1
  for index in "${!_ARRAY[@]}"; do
    [ "${1?}" != "${_ARRAY[${index}]}" ] || { printf '%s' "${index}"; return; }
  done
  >&2 echo "getkey: Value: '$1', not in Array: '${2:-COMP_WORDS}'"
}
