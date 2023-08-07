# shellcheck shell=sh

#######################################
# directories excluded from time machine
# Arguments:
#  None
#######################################
timemachine_excluded() { sudo mdfind "com_apple_backup_excludeItem = 'com.apple.backupd'"; }

#######################################
# removes exclusion in time machine, it will be backed up again
# Arguments:
#  None
#######################################
timemachine_remove_excluded() { sudo tmutil removeexclusion "$@"; }
