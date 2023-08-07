# shellcheck shell=sh

# TODO: completions but do not load twice, manpath and infopath

{ [ "${TERMINAL_EMULATOR}" = "JetBrains-JediTerm" ] || [ "${TTY}" = "not a tty" ]; } || return 0  # JetBrains run and term
_top="$(git rev-parse --show-toplevel 2>/dev/null)"
[ "${_top-}" ] || return 0

pathadd "${_top}/bin"
pythonpathadd "${_top}" "${_top}/src"
! test -f "${_top}/venv/bin/activate" || . "${_top}/venv/bin/activate"
