# shellcheck shell=sh

#######################################
# disable startup of spotify
# Arguments:
#  None
#######################################
spotify() {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -u /Applications/Spotify.app 2>/dev/null || true;
}

! $MACOS || spotify
