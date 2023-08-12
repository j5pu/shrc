# shellcheck shell=bash

$MACOS || return 0

#######################################
# brctl macOS completion
# Globals:
#   COMPREPLY
#   cur
#   cword
#   words
# Arguments:
#  None
# Returns:
#   0 ...
#   <unknown> ...
#######################################
_brctl_macos() {
  _init_completion -n :=/ || return
  local files=false w=()

  case "${cword}" in
    1) w+=(-h --help help diagnose download dump evict log monitor quota status versions) ;;
    2)
      case "${words[1]}" in
        diagnose)
          w+=(--doc -d -M --collect-mobile-documents= -s --sysdiagnose -t --uitest -n --name= -f --full -e --no-reveal)
          files=true
          ;;
        download|evict) files=true ;;
        dump)
          w+=(-o --output -d --database-path= -e --enterprise -i --itemless -u --upgrade)
          files=true
          ;;
        log) w+=(-c --color=yes --color=no -d --path= -H --home= -f --filter= -m --multiline=yes --multiline=no
          -n= -p --page -w --wait -t --horten -s --digest  -a --all -p --predicate -x --process
          --local-timezone) ;;
        monitor) w+=(-g -i -S --scope=);;
        quota|status) return 0 ;;
      versions)
        w+=(-a --all)
        files=true
        ;;
      esac
      ;;
  esac

  mapfile -t COMPREPLY < <(compgen -o nospace -W "${w[*]}" -- "${cur}")
  ! $files || { _filedir; _filedir -d; }
}

# FIXME: completions does not load from external and I doubt from the other
#   finish with the install and move jetbrains a jetbrains. Put jetbrains en el installer?
#   - Put spanish
#   - check applications

complete -F _brctl_macos brctl
