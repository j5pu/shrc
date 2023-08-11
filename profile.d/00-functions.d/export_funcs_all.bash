# shellcheck shell=bash

#######################################
# export all functions
# Arguments:
#  None
#######################################
export_funcs_all() {
  [ "${BASH_VERSION-}" ] || return 0
  # shellcheck disable=SC2046,SC3045,SC3044
  export -f $(compgen -A function)
}
