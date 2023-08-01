# shellcheck shell=sh

! test -x "${HOMEBREW_PREFIX}/bin/brew" || eval "$("${HOMEBREW_PREFIX}/bin/brew" shellenv)"
