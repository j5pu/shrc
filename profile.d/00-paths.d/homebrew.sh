# shellcheck shell=sh

infopathadd "${HOMEBREW_PREFIX?}/share/info"
manpathadd "${HOMEBREW_PREFIX?}/share/man"
pathadd "${HOMEBREW_PREFIX?}/bin" "${HOMEBREW_PREFIX?}/sbin"
