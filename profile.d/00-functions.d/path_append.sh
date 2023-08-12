# shellcheck shell=sh

#######################################
# append directory to variable (PATH, MANPATH, etc.) removing previous entry
# Arguments:
#   1   directory to append
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_append() {
  path_pop "${1:-${PWD}}" "${2-}"
  _path_append_value="$(eval echo "\$${2:-PATH}")"
  if [ "${2:-PATH}" = "MANPATH" ]; then
    _path_append_last=":"
  elif [ "${_path_append_value-}" ]; then
    _path_append_first=":"
  fi
  _path_append_real="$(pwd_p "${1:-${PWD}}" 2>/dev/null)"
  eval "export ${2:-PATH}='${_path_append_value}${_path_append_first-}${_path_append_real}${_path_append_last-}'"
  unset _path_append_first _path_append_last _path_append_real _path_append_value
}
