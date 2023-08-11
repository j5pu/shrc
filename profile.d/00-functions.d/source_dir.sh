# shellcheck shell=sh

source_dir() {
  test -n "$(find "$1" \( -type f -or -type l \) -not -name ".*")" || return 0
  for _rc_source in "$1"/*; do
    case "${_rc_source##*/}" in
      .DS_Store | .gitkeep | .keep | .localized) continue ;;
    esac
    . "${_rc_source}"
  done

  unset _rc_source
}

