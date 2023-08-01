# shellcheck shell=bash

#######################################
# show percentage of $1 from $2 total with $3 decimals (default: 2)
# Arguments:
#   1   value
#   2   total
#   3   extra message
#######################################
outof() { echo -e "\e[32m${1}\e[0m/\e[32m${2} \e[34m$(percentage "$1" "$2")\e[0m%${3:+ $3}"; }
