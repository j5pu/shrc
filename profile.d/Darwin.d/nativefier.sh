# shellcheck shell=bash

#######################################
# create a native app from url
# Arguments:
#  url     required
#  name
#  icon
# Examples:
#  native laSexta /Users/j5pu/CloudDocs/Downloads/unnamed.png https://www.atresplayer.com/directos/lasexta
#  native https://www.atresplayer.com/directos/lasexta
#######################################
native() {
  local app arg params=() tmp url
  tmp="$(mktemp -d)"
  for arg; do
    case "$arg" in
      http*) url="$arg" ;;
      *) if test -f "$arg"; then
           params+=(--icon "$arg")
         else
           params+=(--name "$arg")
         fi
      ;;
    esac
  done
  : "${url?url is required}"
  nativefier --ignore-certificate --single-instance --darwin-dark-mode-support  "${params[@]}"  "$url" "$tmp"
  app="$(find "$tmp" -type d -maxdepth 2 -name "*.app")"
  mv "$app" "/Users/j5pu/Library/Mobile Documents/com~apple~CloudDocs/Applications/nativefier"
  open "/Users/j5pu/Library/Mobile Documents/com~apple~CloudDocs/Applications/nativefier/${app##*/}"
  rm -rf "$tmp"
}
