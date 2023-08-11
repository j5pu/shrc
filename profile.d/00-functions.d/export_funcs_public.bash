# shellcheck shell=bash

#######################################
# export public functions (not starting with _)
# Arguments:
#  None
#######################################
export_funcs_public() {
  [ "${BASH_VERSION-}" ] || return 0
  # shellcheck disable=SC2046,SC3045,SC3044
  export -f $(compgen -A function | grep -v '^_')
}
