# shellcheck shell=sh

#######################################
# is directory in variable (PATH, MANPATH, etc.)
# Globals:
#   PATH
# Arguments:
#   1   directory to check
#   2   variable name (default: PATH)
# Returns:
#   0 if directory in $PATH
#   1 if directory not in $PATH, parameter null or parameter not set
#######################################
path_in() {
  [ "${2:-PATH}" = "MANPATH" ] || _path_in_add=":"
  _path_in_real="$("${SHRC_BIN}/pwd_p" "${1:-${PWD}}")"
  case ":$(eval echo "\$${2:-PATH}")${_path_in_add-}" in
    *:"${_path_in_real}":*) unset _path_in_add _path_in_real; return 0 ;;
    *) unset _path_in_add _path_in_real; return 1 ;;
  esac
}

