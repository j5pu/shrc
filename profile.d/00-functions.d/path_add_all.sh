# shellcheck shell=sh

#######################################
# add/prepend dir/sbin:dir/bin:dir/libexec, dir/share/info and dir/share/man removing previous entries
# Globals:
#   PATH
# Arguments:
#   1   directory
# Returns:
#   1   parameter null or not set
#######################################
path_add_all() {
  for _path_add_all in libexec bin sbin; do
    path_add "${1:-${PWD}}/${_path_add_all}"
  done
  path_add "${1:-${PWD}}/share/man" MANPATH
  path_add "${1:-${PWD}}/share/info" INFOPATH
  unset _path_add_all
}

