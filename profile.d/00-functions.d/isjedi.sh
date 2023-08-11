# shellcheck shell=sh

#######################################
# check is running configuration or running in jetbrains terminal and sets project super top variable
# Globals:
#   JEDI_TOP
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
isjedi() {
  [ "${TERMINAL_EMULATOR-}" = "JetBrains-JediTerm" ] || [ "${TTY-}" = "not a tty" ] || return
  # Set to top level of project if running in run or in jediterm
  #
  export JEDI_TOP
  JEDI_TOP="$(superproject)"
}
