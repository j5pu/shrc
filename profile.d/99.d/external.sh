# shellcheck shell=sh


# TODO: Aquí lo dejo. Hacer sims for share, bin.

infopathadd "${JEDI_TOP}/share/info"
manpathadd "${JEDI_TOP}/share/man" "$(find "${SHRC_EXTERNAL_MAN}" -type d)"
pathadd "${JEDI_TOP}/bin" "$(find "${SHRC_EXTERNAL_BIN}" -type d)"
pythonpathadd "${JEDI_TOP}" "${JEDI_TOP}/src"
! test -f "${JEDI_TOP}/venv/bin/activate" || . "${JEDI_TOP}/venv/bin/activate"
