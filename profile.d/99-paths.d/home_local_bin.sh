# shellcheck shell=sh


pathadd "${DEFAULT_HOME}/.local/bin"
[ "${DEFAULT_HOME}" != "${HOME}" ] || return 0
pathadd "${HOME}/.local/bin"
