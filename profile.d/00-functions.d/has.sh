# shellcheck shell=sh

#######################################
# has alias, command or function
# Arguments:
#   1   alias, command or function name
# Returns:
#   1   parameter null or not set
#######################################
has() { type "$@" 1>/dev/null 2>&1; }

