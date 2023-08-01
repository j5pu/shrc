# shellcheck shell=sh

#######################################
# total du for directory/ies or cwd
# Arguments:
#  None
#######################################
du_total() { du -hs "$@"; }
