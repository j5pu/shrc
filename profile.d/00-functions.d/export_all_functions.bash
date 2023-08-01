# shellcheck shell=bash


#######################################
# export all functions in bash except private _
# Arguments:
#  None
#######################################
export_all_functions() {
  # shellcheck disable=SC2046
  export -f $(compgen -A function | grep -v '^_')
}
