# shellcheck shell=bash

#######################################
# percentage of $1 from $2 total with $3 decimals (default: 2)
# Arguments:
#   1   value
#   2   total
#   3   number of decimals (default: 2)
#######################################
percentage() { awk "BEGIN{printf \"%.${3:-2}f\n\",${1}/${2}*100}"; }
