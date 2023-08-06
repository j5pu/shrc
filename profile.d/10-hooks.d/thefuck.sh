# shellcheck shell=sh

[ "${PS1-}" ] || return 0

! cmd thefuck || eval "$(thefuck --alias)"
