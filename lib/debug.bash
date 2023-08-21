#!/bin/bash

set -o errexit # exit on errors
set -o nounset # exit on use of uninitialized variable
set -o errtrace # inherits trap on ERR in function and subshell

trap 'traperror $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]:-})' ERR
trap 'trapexit $? $LINENO' EXIT

#######################################
# description
# Arguments:
#   0
#   1
#   2
#######################################
trapexit() {
  echo "$(date) $(hostname) $0: EXIT on line $2 (exit status $1)"
}

#######################################
# description
# Arguments:
#   0
#   1
#   2
#   3
#   4
#   5
#######################################
traperror () {
    local err=$1 # error status
    local line=$2 # LINENO
    local linecallfunc=$3
    local command="$4"
    local funcstack="$5"
    echo "$(date) $(hostname) $0: ERROR '$command' failed at line $line - exited with status: $err" 

    if [ "$funcstack" != "::" ]; then
      echo -n "$(date) $(hostname) $0: DEBUG Error in ${funcstack} "
      if [ "$linecallfunc" != "" ]; then
        echo "called at line $linecallfunc"
      else
        echo
      fi
    fi
    echo "'$command' failed at line $line - exited with status: $err" | \
      mail -s "ERROR: $0 on $(hostname) at $(date)" j5pu@icloud.com
}

#######################################
# description
# Globals:
#   BASH_LINENO
#   BASH_SOURCE
#   FUNCNAME
#   lineno
#   now
# Arguments:
#   0
#   1
#######################################
log() {
    local msg=$1 lineno now
    now=$(date)
    i=${#FUNCNAME[@]}
    lineno=${BASH_LINENO[$i-2]}
    file=${BASH_SOURCE[$i-1]}
    echo "${now} $(hostname) $0:${lineno} ${msg}"
}