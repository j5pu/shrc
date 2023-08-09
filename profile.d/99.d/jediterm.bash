# shellcheck shell=bsh

isjedi || return 0

# Sources completions in top directory
source_files_if_bash4_and_ps1  "${JEDI_TOP}"
