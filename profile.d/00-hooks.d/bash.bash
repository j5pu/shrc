# shellcheck shell=bash

set -o errtrace functrace

[ "${PS1-}" ] || return 0

# https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps
# CTRL+R -> history search, and CTRL+S -> history search backward
# $ sudo (I want know completions .. CTRL+A CTRL+R CTRL+Y ... CTRL+R
stty -ixon

# https://zwischenzugs.com/2019/04/03/eight-obscure-bash-options-you-might-want-to-know-about/
#
shopt -s autocd cdable_vars checkwinsize dotglob execfail histappend nocaseglob nocasematch
[ "${BASH_VERSINFO[0]:-0}" -lt 4 ] || shopt -s direxpand dirspell globstar progcomp_alias
