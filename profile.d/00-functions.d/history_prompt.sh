# shellcheck shell=sh

#######################################
# description
# Arguments:
#  None
# Returns:
#   $__history_prompt_rc ...
#######################################
history_prompt() {
  # shellcheck disable=SC3043
  local __history_prompt_rc=$?
  history -a; history -c; history -r; hash -r
  return $__history_prompt_rc
}

