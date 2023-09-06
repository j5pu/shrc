# shellcheck shell=sh

! test -f "${HOMEBREW_PREFIX}/etc/grc.sh" || GRC_ALIASES=true . "${HOMEBREW_PREFIX}/etc/grc.sh"

alias atlasip='atlas accessLists create $(mydigip)/32'
alias bb=" brew update && brew upgrade && brew cleanup && brew autoremove && brew bundle dump --force && \
  brew bundle install --no-lock --cleanup && brew cleanup --prune=all"
if cmd docker; then
  alias ddisk="docker system df"

  alias devents="docker system events"
  alias dimagesall="docker images -a"
  alias dinfo="docker system info"
  alias dprune="docker system prune --all --volumes --force"
fi
! cmd direnv || { alias allow='direnv allow'; alias reload='direnv reload'; }
alias disco="du -sh"
! cmd exa || alias exa='exa --classify'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

if cmd grc; then
  alias grcat='grc cat'
  alias grhead='grc head'
  alias grtail='grc tail'
fi
alias l='ls -lah'
alias la='ls -lAh'
#alias ll='ls -lh'
#alias l1='ls -1'
#alias l='ls -a'
#alias la='ls -AF' # Compact view, show hidden
if ls --color -d . >/dev/null 2>&1; then
  # shellcheck disable=SC2262
  alias ls="ls --color=auto"
elif ls -G -d . >/dev/null 2>&1; then
  alias ls='ls -G'
fi
alias lsa='ls -lah'
! cmd lsd || alias ls="lsd"
alias myip="curl -s http://whatismyip.akamai.com/"
alias mydigip="dig +short myip.opendns.com @resolver1.opendns.com"
alias now="shutdown -h now"
! cmd pgrep || alias pgrep="pgrep -i"
alias rsync_d="rsync -v -a --delete-after --checksum"
#alias scale-check="rclone check --progress --s3-storage-class=GLACIER"
#alias scale-cleanup="rclone cleanup --progress --s3-storage-class=GLACIER"
#alias scale-copy="rclone copy --progress --s3-storage-class=GLACIER"
#alias scale-delete="rclone delete --progress --s3-storage-class=GLACIER"
#alias scalels="rclone ls --progress --s3-storage-class=GLACIER scaleway:/"
#alias scalelsd="rclone lsd --progress --s3-storage-class=GLACIER scaleway:/"
#alias scalelsl="rclone lsl --progress --s3-storage-class=GLACIER scaleway:/"
#alias scale-mkdir="rclone mkdir --progress --s3-storage-class=GLACIER"
#alias scale-move="rclone move --progress --s3-storage-class=GLACIER"
#alias scale-purge="rclone purge --progress --s3-storage-class=GLACIER"
#alias scale-rmdir="rclone rmdir --progress --s3-storage-class=GLACIER"
#alias scale-rmdirs="rclone rmdirs --progress --s3-storage-class=GLACIER"
#alias scale-size="rclone size --progress --s3-storage-class=GLACIER scaleway:/"
#alias scale-sync="rclone sync --progress --s3-storage-class=GLACIER"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"
# https://superuser.com/questions/1220872/how-can-i-pass-an-alias-to-sudo
#
#alias sudo="sudo "

if cmd tree; then
  alias tree1="tree -d -L 1"
  alias tree2="tree -d -L 2"
  alias tree="tree -C" # Always use colored `tree` output
  alias treed="tree -d"
fi
if cmd vim; then alias vi=vim; else alias vim=vi; fi

if $MACOS; then

  alias assetcache="AssetCacheManagerUtil flushCache; AssetCacheManagerUtil flushPersonalCache; \
    AssetCacheManagerUtil flushSharedCache"
  alias backups="tmutil listbackups"
  alias finder="open ." # Open current directory in Finder
  alias pending="brctl status | grep -c Under; brctl dump --upgrade | \
    egrep '    \+ downloads:|    \+ uploads:|    \+ apply:|      up:'"
  alias pltobin="plutil -convert binary1" # This changes the plist in XML back to binary format
  alias pltoxml="plutil -convert xml1"    # This converts the existing binary plist file into XML format
  alias spotify="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/\
Support/lsregister -u /Applications/Spotify.app 2>/dev/null || true"
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
  alias timemachine_excluded="mdfind \"com_apple_backup_excludeItem = 'com.apple.backupd'\""
  alias timemachine_remove_excluded="tmutil removeexclusion"
  alias update="apt update"
else
  alias apt-all="apt update -y; apt upgrade -y; apt dist-upgrade -y; apt autoremove -y; apt autoclean -y"
  alias networking="sudo /etc/init.d/networking"
  alias update="softwareupdate -aiR" # Install all macOS updates and restart system
  alias updatedb='updatedb'
fi
