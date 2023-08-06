# shellcheck shell=sh

[ "${PS1-}" ] || return 0

{ ! cmd zoxide || [ ! "${SHRC_HOOKS_SHELL-}" ]; } || eval "$(zoxide init "${SHRC_HOOKS_SHELL}")"
