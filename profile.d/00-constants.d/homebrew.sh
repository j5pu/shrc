# shellcheck shell=sh

! cmd brew || eval "$(brew shellenv)"

export HOMEBREW_BAT=1
export HOMEBREW_BUNDLE_FILE="${HOME}/bbin/Brewfile"
# export HOMEBREW_CACHE="/Volumes/USB-2TB/Library/Caches/Homebrew"
#  export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --no-quarantine"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
# export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
export HOMEBREW_PRY=1
# export HOMEBREW_TEMP="/Volumes/USB-2TB/tmp"
#  export INFOPATH="${HOMEBREW_PREFIX}/info:${INFOPATH:-}"
