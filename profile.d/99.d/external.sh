# shellcheck shell=sh

manpathadd  $(find "${SHRC_EXTERNAL_MAN}" -type d)
pathadd $(find "${SHRC_EXTERNAL_BIN}" -type d)
