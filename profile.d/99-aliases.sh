# shellcheck shell=bash

! test -f "${HOMEBREW_PREFIX}/etc/grc.sh" || GRC_ALIASES=true . "${HOMEBREW_PREFIX}/etc/grc.sh"

alias allow='direnv allow'
alias assetcache="sudo AssetCacheManagerUtil flushCache; sudo AssetCacheManagerUtil flushPersonalCache; sudo AssetCacheManagerUtil flushSharedCache"
alias bb=" brew update && brew upgrade && brew cleanup && brew autoremove && brew bundle dump --force && \
  brew bundle install --no-lock --cleanup && brew cleanup --prune=all"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'
alias lsa='ls -lah'
! cmd lsd || alias ls="lsd"
alias now="sudo shutdown -h now"
alias pending="brctl status | grep -c Under; brctl dump --upgrade | egrep '    \+ downloads:|    \+ uploads:|    \+ apply:|      up:'"
alias reload='direnv reload'
alias spotify="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister\
  -u /Applications/Spotify.app 2>/dev/null || true"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

alias timemachine_excluded="sudo mdfind \"com_apple_backup_excludeItem = 'com.apple.backupd'\""
alias timemachine_remove_excluded="sudo tmutil removeexclusion"