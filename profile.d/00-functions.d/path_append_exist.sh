# shellcheck shell=sh


#######################################
# append directory to variable (PATH, MANPATH, etc.) removing previous entry
# Arguments:
#   1   directory to append
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_append_exist() { path_pop "${1:-${PWD}}" "${2-}"; [ ! -d "${1:-${PWD}}" ] || path_append "${1:-${PWD}}" "${2-}"; }

