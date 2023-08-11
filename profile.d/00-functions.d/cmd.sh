# shellcheck shell=sh

#######################################
# check if command exits
# Arguments:
#  command
#######################################
cmd() { command -v "${1}" >/dev/null; }
