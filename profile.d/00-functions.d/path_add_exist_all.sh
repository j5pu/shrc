# shellcheck shell=sh

#######################################
# add/prepend dir/sbin:dir/bin:dir/libexec, dir/share/info and dir/share/man removing previous entries if exist
# Globals:
#   PATH
# Arguments:
#   1   directory
# Returns:
#   1   parameter null or not set
#######################################
path_add_exist_all() {
  for _path_add_exist_all in libexec bin sbin; do
    path_add_exist "${1:-${PWD}}/${_path_add_exist_all}"
  done
  path_add_exist "${1:-${PWD}}/share/man" MANPATH
  path_add_exist "${1:-${PWD}}/share/info" INFOPATH
  unset _path_add_exist_all
}

