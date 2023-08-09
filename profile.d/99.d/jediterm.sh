# shellcheck shell=sh

isjedi || return 0

infopathadd "${SUPERPROJECT}/share/info"
manpathadd "${SUPERPROJECT}/share/man"
pathadd "${SUPERPROJECT}/bin"
pythonpathadd "${SUPERPROJECT}" "${SUPERPROJECT}/src"
! test -f "${SUPERPROJECT}/venv/bin/activate" || . "${SUPERPROJECT}/venv/bin/activate"
