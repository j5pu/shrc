# shellcheck shell=sh

#######################################
# change to git repository top path and exit if not git repository
# Arguments:
#  None
# Returns:
#   1 if not git repository (exit)
#######################################
cd_top_exit() { cd_top || exit; }

