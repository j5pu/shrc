# shellcheck shell=sh

test -x "${HOMEBREW_PREFIX?}/bin/brew" || return 0

eval "$("${HOMEBREW_PREFIX}/bin/brew" shellenv)"
