# shellcheck shell=sh

#######################################
# file stem
# Arguments:
#   1
# Examples:
#   stem /hola.xz/example.tar.gz
#   stem /hola.xz/example
#######################################
stem() { echo "${1##*/}" | sed -e 's/\.[^\.]*$//'; }
