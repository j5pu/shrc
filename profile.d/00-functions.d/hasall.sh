# shellcheck shell=sh

#######################################
# command or commands exists
# Arguments:
#  command [command]    command or commands
# Returns:
#  1 if any of the command does not exist
#######################################
hasall() {
  _help="$(cat <<EOF
usage: hasall [command...]
       . utils.sh; hasall [function...]
       hasall [-h|--help|help]

command, builtin, function, alias exists

Arguments:
  [command...]          command, builtin and function or alias when sourced

Commands:
   -h, --help, help     display this help and exit.

Returns:
   1 if at least one of commands does not exist
EOF
)"
  if test $# -eq 0; then
    echo "${_help}"; exit 1
  else
    case "$1" in
      -h|--help|help) echo "${_help}"; exit 0 ;;
    esac
  fi

  if [ $# -eq 1 ]; then
    type "$1" >/dev/null 2>&1
  else
    tmp="$(mktemp)"
    type "$@" >/dev/null 2>"${tmp}"
    ! test -s "${tmp}" || grep -qv "not found" "${tmp}"
  fi
}


