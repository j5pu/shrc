# shellcheck shell=sh

#######################################
# source files if bash4 and interactive, i.e.: completions
# Arguments:
#  user     default $GIT or $USER
#######################################
source_files_if_bash4_and_ps1() { ! $BASH4 || [ ! "${PS1-}" ] || source_files "$@"; }
