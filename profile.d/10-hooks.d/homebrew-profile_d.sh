# shellcheck shell=bash


# source: homebrew profile.d
#
[ ! "${SHELL_ARGZERO-}" ] || ! test -d "${HOMEBREW_PREFIX}/etc/profile.d" || source_files "${HOMEBREW_PREFIX}/etc/profile.d"/*
