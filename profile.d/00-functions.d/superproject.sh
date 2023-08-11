# shellcheck shell=sh

#######################################
#git superproject top directory
# Arguments:
#  user     default $GIT or $USER
#######################################
superproject() {
  git rev-parse --show-superproject-working-tree --show-toplevel 2>/dev/null | head -1
}