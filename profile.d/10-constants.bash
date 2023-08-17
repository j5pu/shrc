# shellcheck shell=bash

# Depends on: [00-functions.d/cmd.sh](../00-functions.d/cmd.sh)
#

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


[ "${PS1-}" ] || return 0

cmd starship || export PS2="${BlueDim}> "


export PS4="+ [${Magenta}\$(basename \"\${BASH_SOURCE[0]}\")${Reset}][${Magenta}\${LINENO}${Reset}]\
[${Yellow}\$(echo \${BASH_LINENO[*]} | awk '{\$NF=\"\"; print \$0}' | sed 's/ \$//g'| sed 's/ /@/g')${Reset}]\
${Green}$ ${Reset}"
