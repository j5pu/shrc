# shellcheck shell=bash disable=SC2046

addinfopath "${HOMEBREW_PREFIX?}/share/info" "${SHRC_SHARE}/info"
addmanpath "${HOMEBREW_PREFIX?}/share/man" "${SHRC_SHARE}/man"
addpath "${HOMEBREW_PREFIX?}/bin" "${HOMEBREW_PREFIX?}/sbin" "${HOME}/bin" "${HOME}/.local/bin" \
  "${SHRC_BIN}" "${SHRC_LIB}" "${SHRC_GENERATED_COLOR}"
! cmd pyenv || { eval "$(pyenv init --path)"; eval "$(pyenv init -)"; }

if isjedi && [ "${JEDI_TOP}" != "${SHRC}" ]; then
  addinfopath "${JEDI_TOP}/share/info"
  addmanpath "${JEDI_TOP}/share/man"
  addpath "${JEDI_TOP}/bin"
  addpythonpath "${JEDI_TOP}" "${JEDI_TOP}/src"
  ! test -f "${JEDI_TOP}/venv/bin/activate" || . "${JEDI_TOP}/venv/bin/activate"
fi

source_files $(printf "%s\n" "${SHRC_EXTERNAL_PROFILE_D}"/*.sh  \
  "${SHRC_EXTERNAL_PROFILE_D}"/*."${SH_HOOK}"  "${SHRC_EXTERNAL_PROFILE_D}"/*."${SH_SOURCE}" | sort -u)
addmanpath $(find -L "${SHRC_EXTERNAL_MAN}" -type d)
addpath $(find -L "${SHRC_EXTERNAL_BIN}" -type d)


{ [ "${PS1-}" ] && [ "${SH_ARGZERO-}" ] && [ "${SH_HOOK-}" ]; } || return 0


! test -d "${HOMEBREW_PREFIX}/etc/profile.d" || source_files "${HOMEBREW_PREFIX}/etc/profile.d"/*
bind -x '"\C-x\C-r": pet_select'
! cmd starship || eval "$(starship init "${SH_HOOK}")"
! cmd thefuck || eval "$(thefuck --alias)"
! cmd zoxide || eval "$(zoxide init "${SH_HOOK}")"
export PROMPT_COMMAND="history_prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

$BASH4 || return 0

source_files  "${SHRC_COMPLETION_D}"/**/*
[ "${JEDI_TOP}" = "${SHRC}" ] || source_files  "${JEDI_TOP}/bash_completion.d"
source_files  "${SHRC_EXTERNAL_COMPLETION_D}"/*
