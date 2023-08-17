# shellcheck shell=sh

#######################################
# file extension if has . on filename otherwise empty
# Arguments:
#   1
# Examples:
#   extension /hola.xz/example.tar.gz
#   extension /hola.xz/example
#######################################
extension() { echo "${1##*/}" | awk -F "." '/\./ { print $NF }'; }
