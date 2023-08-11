# shellcheck shell=sh

#######################################
# removes directory from variable (PATH, MANPATH, etc.)
# Globals:
#   PATH
# Arguments:
#   1   directory to remove
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_pop() {
  [ "${2:-PATH}" = "MANPATH" ] || _path_pop_strip=":"
  _path_pop_real="$("${SHRC_BIN}/pwd_p" "${1:-${PWD}}")"
  _path_pop_value="$(eval echo "\$${2:-PATH}" | sed 's/:$//' | tr ':' '\n' | \
    grep -v "^${_path_pop_real}$" | tr '\n' ':' | sed "s|${_path_pop_strip-}$||")"
  [ "${_path_pop_value}" != ":" ] || _path_pop_value=""
  eval "export ${2:-PATH}='${_path_pop_value}'"
  unset _path_pop_real _path_pop_strip _path_pop_value
}

