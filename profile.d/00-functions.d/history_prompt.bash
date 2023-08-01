# shellcheck shell=bash

[ "${PS1-}" ] || return 0

#######################################
# command prompt for bash
# Arguments:
#  None
# Returns:
#   $__history_prompt_rc ...
#######################################
history_prompt() {
  local __history_prompt_rc=$?
  history -a; history -c; history -r; hash -r
  return $__history_prompt_rc
}
