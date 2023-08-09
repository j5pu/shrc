# shellcheck shell=bash


#######################################
# load completions from a directory using BASH_COMPLETION_USER_DIR
# Arguments:
#   1
#######################################
load_completion() {
  # when sourced in a script not in bash4 will not be loaded by bash_completion in brew
  [ ! "${SHELL_ARGZERO-}" ] || BASH_COMPLETION_USER_DIR="$1" __load_completion
}
