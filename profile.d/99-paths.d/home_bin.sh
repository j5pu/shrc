# shellcheck shell=sh

pathadd "${DEFAULT_HOME}/bin"
[ "${DEFAULT_HOME}" != "${HOME}" ] || return 0
pathadd "${HOME}/bin"
