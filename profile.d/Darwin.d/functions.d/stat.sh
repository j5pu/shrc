# shellcheck shell=sh

#######################################
# list of files size found in directory
# Arguments:
#  None
#######################################
size() { find . -type f -name "${*}" -exec stat -f '%z' "{}" \;; }

