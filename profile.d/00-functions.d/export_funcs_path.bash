# shellcheck shell=bash

#######################################
# export file or files functions
# Arguments:
#  Files or Directories to search for functions
#######################################
export_funcs_path() {
  [ "${BASH_VERSION-}" ] || return 0
  # shellcheck disable=SC2046,SC3045
  export -f $(filefuncs  "$@")
}
