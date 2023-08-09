# shellcheck shell=bash

{ [ "${PS1-}" ] && [ "${SHELL_ARGZERO-}" ]; } || return 0

bind -x '"\C-x\C-r": pet_select'
