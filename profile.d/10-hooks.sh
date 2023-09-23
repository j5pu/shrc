# shellcheck shell=sh disable=SC2046,SC3045

addinfopath "${HOMEBREW_PREFIX?}/share/info" "${SHRC_SHARE}/info"
addmanpath "${HOMEBREW_PREFIX?}/share/man" "${SHRC_SHARE}/man"
addpath "${HOMEBREW_PREFIX}/bin" "${HOMEBREW_PREFIX}/sbin" "${HOME}/bin" "${HOME}/.local/bin" \
  "${SHRC_BIN}" "${SHRC}/sudo" "${SHRC_LIB}" "${SHRC_GENERATED_COLOR}"
! cmd pyenv || { eval "$(pyenv init --path)"; eval "$(pyenv init -)"; }

if isjedi && [ "${JEDI_TOP}" != "${SHRC}" ] && [ "${JEDI_TOP}" != "${HOME}" ]; then
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

[ "${INTELLIJ_ENVIRONMENT_READER-}" ] || ! cmd bash_export_funcs_public || bash_export_funcs_public


{ [ "${PS1-}" ] && [ "${SH_ARGZERO-}" ] && [ "${SH_HOOK-}" ]; } || return 0

[ "${INTELLIJ_ENVIRONMENT_READER-}" ] || generate_aliases
[ "${INTELLIJ_ENVIRONMENT_READER-}" ] || generate_sudo

! test -d "${HOMEBREW_PREFIX}/etc/profile.d" || source_files "${HOMEBREW_PREFIX}/etc/profile.d"/*

# https://youtrack.jetbrains.com/articles/IDEA-A-19/Shell-Environment-Loading
#
[ ! "${INTELLIJ_ENVIRONMENT_READER-}" ] || return 0

bind -x '"\C-x\C-r": pet_select'

! cmd "env_parallel.${SH_HOOK}" || . "env_parallel.${SH_HOOK}"

! cmd direnv || { eval "$(direnv hook "${SH_HOOK}")" && export -f _direnv_hook; }


if cmd starship && [ "${SHRC_PROMPT}" -eq 0 ]; then
  eval "$(starship init "${SH_HOOK}")"
  # shellcheck disable=SC2034,SC3030,SC3024
  case "${SH_HOOK}" in
    bash) starship_precmd_user_func="prompt_title"; export -f starship_precmd _starship_set_return;;
    zsh) precmd_functions+=(prompt_title) ;;
  esac
else
  # shellcheck disable=SC2016,SC2034
  case "${SH_HOOK}" in
  bash) export PROMPT_COMMAND="bash_prompt \$?${PROMPT_COMMAND:+; ${PROMPT_COMMAND}}" ;;
  zsh)
    PROMPT='$(prompt $? "${SH}")'
    PROMPT2='$(prompt ps2 "${SH}" )'
    ;;
  *) PS1="\$(prompt \$? ${SH})" ;; # dash, sh, busybox need a script.
esac
  PS2="$(prompt ps2 "${SH-}")"
fi

! cmd thefuck || eval "$(thefuck --alias)"
! cmd zoxide || { eval "$(zoxide init "${SH_HOOK}")" && export -f __zoxide_hook __zoxide_pwd; }

export PROMPT_COMMAND="history_prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

$BASH4 || return 0

source_files  "${SHRC_COMPLETION_D}"/**/*
[ "${JEDI_TOP}" = "${SHRC}" ] || ! test -d  "${JEDI_TOP}/bash_completion.d" || \
  source_files  "${JEDI_TOP}/bash_completion.d"/*
source_files  "${SHRC_EXTERNAL_COMPLETION_D}"/*
