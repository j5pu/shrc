# shellcheck shell=sh

#######################################
# add/prepend directory to variable (PATH, MANPATH, etc.) removing previous entries if directory exists
# Arguments:
#   1   directory to add
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_add_exist() { path_pop "${1:-${PWD}}" "${2-}"; [ ! -d "${1:-${PWD}}" ] || path_add "${1:-${PWD}}" "${2-}"; }

