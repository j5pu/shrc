# shellcheck shell=bash

#######################################
# export all functions
# Arguments:
#  None
#######################################
# shellcheck disable=SC2046
bash_export_funcs_all() { ! cmd compgen || export -f $(compgen -A function); }

#######################################
# export file or files functions
# Arguments:
#  Files or Directories to search for functions
#######################################
# shellcheck disable=SC2046
bash_export_funcs_path() { export -f $(filefuncs "$@"); }

#######################################
# export all functions in bash except private _
# Arguments:
#  None
#######################################
bash_export_funcs_public() { export_funcs_all | grep -v '^_'; }

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
    [[ "${array}" =~ "declare "-[a,A] ]] || {
      echo >&2 "cparray: undefined array: ${array}"
      return 1
    }
    echo "cparray: _ARRAY=$(cut -d '=' -f 2- <<<"${array}")"

    _ARRAY=()
    for key in "${!array[@]}"; do
      _ARRAY["${key}"]="$(cut -d '=' -f 2- <<<"${array}")"
    done
  else
    echo >&2 "cparray: ${array[*]}"
    return 1
  fi

}

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
    [ "${1?}" != "${_ARRAY[${index}]}" ] || {
      printf '%s' "${index}"
      return
    }
  done
  echo >&2 "getkey: Value: '$1', not in Array: '${2:-COMP_WORDS}'"
}

#######################################
# check if key in array and shows value or nothing with no errors (former name: default)
# Globals:
#   _ARRAY
# Arguments:
#   key         the value to search
#   [array]     array name (default: COMP_WORDS)
# Returns:
#   1 if invalid array
#######################################
getvalue() {
  cparray "${2-}" || return 1
  printf '%s' "${_ARRAY["${1?}"]}" 2>/dev/null || true
}

#######################################
# command prompt for bash
# Arguments:
#  None
# Returns:
#   $__history_prompt_rc ...
#######################################
history_prompt() {
  local __history_prompt_rc=$?
  history -a; history -c; history -r; hash -r
  return $__history_prompt_rc
}

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
inarray() { getkey "$@" >/dev/null; }

#######################################
# Register the previous command easily
# https://github.com/knqyf263/pet#bash-prev-function
# Arguments:
#  None
#######################################
pet_prev() {
  local PREV
  PREV=$(history | tail -n2 | head -n1| sed 's/[0-9]*//' | xargs)
  sh -c "pet new $(printf %q "${PREV}")"
}

#######################################
# search snippets and output on the shell. Select snippets at the current line (like C-r)
# https://github.com/knqyf263/pet#select-snippets-at-the-current-line-like-c-r
# Globals:
#   BUFFER
#   READLINE_LINE
#   READLINE_POINT
# Arguments:
#  None
#######################################
pet_select() {
  local buffer

  buffer=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$buffer
  READLINE_POINT=${#buffer}
}

