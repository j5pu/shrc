# shellcheck shell=sh disable=SC3045

[ "${PS1-}" ] || return 0

{ ! cmd zoxide || [ ! "${SHRC_HOOKS_SHELL-}" ]; } || eval "$(zoxide init "${SHRC_HOOKS_SHELL}")"
