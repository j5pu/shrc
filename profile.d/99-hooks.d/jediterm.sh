# shellcheck shell=sh


[ "${TERMINAL_EMULATOR}" = "JetBrains-JediTerm" ] || return 0
_top="$(git rev-parse --show-toplevel 2>/dev/null)"
[ "${_top-}" ] || return 0

# FIXME: It passing two times
echo hola
# TODO: completions but do not load twice, manpath and infopath
! test -d "${_top}/bin" || export PATH="${_top}/bin:${PATH}"
export PYTHONPATH="${_top}${PYTHONPATH:+:${PYTHONPATH}}"
! test -d "${_top}/src" || export PYTHONPATH="${_top}/src${PYTHONPATH:+:${PYTHONPATH}}"
! test -f "${_top}/venv/bin/activate" || . "${_top}/venv/bin/activate"
