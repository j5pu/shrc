# shellcheck shell=bash


#######################################
# check if value in array exists
# Globals:
#   _ARRAY
# Arguments:
#   value       the value to search
#   [array]     array name (default: COMP_WORDS)
# Returns:
#   1 if value not in array, or invalid array
#######################################
inarray() {
  getkey "$@" >/dev/null
}
