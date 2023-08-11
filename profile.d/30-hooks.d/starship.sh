# shellcheck shell=sh

[ "${PS1-}" ] || return 0

{ ! cmd starship || [ ! "${SHRC_HOOKS_SHELL-}" ]; } || eval "$(starship init "${SHRC_HOOKS_SHELL}")"
