# shellcheck shell=sh disable=SC2046

! test -d "${SHRC_EXTERNAL_BIN}" || pathadd $(find -L "${SHRC_EXTERNAL_BIN}" -type d)
! test -d "${SHRC_EXTERNAL_MAN}" || manpathadd  $(find -L "${SHRC_EXTERNAL_MAN}" -type d)

if test -d "${SHRC_EXTERNAL_PROFILE_D}"; then
  source_files "${SHRC_EXTERNAL_PROFILE_D}"/*.sh
   [ ! "${SHRC_HOOKS_SHELL-}" ] || source_files  "${SHRC_EXTERNAL_PROFILE_D}"/*."${SHRC_HOOKS_SHELL}"
fi

! test -d "${SHRC_EXTERNAL_COMPLETION_D}" || source_files_if_bash4_and_ps1  "${SHRC_EXTERNAL_COMPLETION_D}"/*
