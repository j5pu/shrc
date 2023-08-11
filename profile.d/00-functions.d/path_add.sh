# shellcheck shell=sh

#######################################
# add/prepend directory to variable (PATH, MANPATH, etc.) removing previous entries
# Globals:
#   PATH
# Arguments:
#   1   directory to add
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_add() {
  path_pop "${1:-${PWD}}" "${2-}"
  _path_add_value="$(eval echo "\$${2:-PATH}")"
  _path_add_value="${_path_add_value:+:${_path_add_value}}"
  [ "${2:-PATH}" != "MANPATH" ] || [ "${_path_add_value-}" ] || _path_add_value=":"
  _path_add_real="$("${SHRC_BIN?}/pwd_p" "${1:-${PWD}}" )"
  eval "export ${2:-PATH}='${_path_add_real}${_path_add_value}'"
  unset _path_add_value _path_add_real
}

