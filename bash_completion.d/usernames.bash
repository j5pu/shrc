# shellcheck shell=bash

#######################################
# completions for shrc
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_shrc() {
  _init_completion -n :=/ || return
  local w=(-h --help help all clean install uninstall)

  [[ ! "${words[1]}" =~ -h|--help|help|all|clean|install|uninstall ]] || return 0

  mapfile -t COMPREPLY < <(compgen -o nospace -W "${w[*]}" -- "${cur}")
}

complete -F _shrc shrc
