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
  local array key
  if array="$(declare -p "${1:-COMP_WORDS}" 2>&1)"; then
    [[ "${array}" =~ "declare "-[a,A] ]] || { >&2 echo "cparray: undefined array: ${array}"; return 1; }
    echo "cparray: _ARRAY=$(cut -d '=' -f 2- <<< "${array}")"

    _ARRAY=()
    for key in "${!array[@]}"; do
      _ARRAY["${key}"]="$(cut -d '=' -f 2- <<< "${array}")"
    done
  else
    >&2 echo "cparray: ${array[*]}"
    return 1
  fi

}
