# shellcheck shell=sh

isjedi || return 0

infopathadd "${JEDI_TOP}/share/info"
manpathadd "${JEDI_TOP}/share/man"
pathadd "${JEDI_TOP}/bin"
pythonpathadd "${JEDI_TOP}" "${JEDI_TOP}/src"
! test -f "${JEDI_TOP}/venv/bin/activate" || . "${JEDI_TOP}/venv/bin/activate"
