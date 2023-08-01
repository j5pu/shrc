# shellcheck shell=sh

#######################################
# rsync directory preserving attrs, permissions and dates
# Arguments:
#  None
#######################################
rsync_preserve() { rsync -avAXUN E --exclude "*.icloud" "$@"; }
