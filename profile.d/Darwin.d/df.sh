# shellcheck shell=sh

#######################################
# macOS disk1 free
# Arguments:
#  None
#######################################
df_macos() { df -H | awk '/\/dev\/disk1s1/ { printf $4 }'; }
