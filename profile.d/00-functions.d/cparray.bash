# shellcheck shell=bash

#######################################
# copy array name to _ARRAY
# Globals:
#   _ARRAY
# Arguments:
#   [array]     array name (default: COMP_WORDS)
# Returns:
#   1 if invalid array name or type
#######################################
cparray() {
  local declare
  if declare="$(declare -p "${1:-COMP_WORDS}" 2>&1)"; then
    [[ "${declare}" =~ "declare "-[a,A] ]] || { >&2 echo "cparray: undefined array: ${declare}"; return 1; }
    eval "_ARRAY=$(cut -d '=' -f 2- <<< "${declare}")"
  else
    >&2 echo "cparray: ${declare}"
    return 1
  fi
}
