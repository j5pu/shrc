# shellcheck shell=sh

! test -f "${HOMEBREW_PREFIX}/etc/grc.sh" || GRC_ALIASES=true . "${HOMEBREW_PREFIX}/etc/grc.sh"
