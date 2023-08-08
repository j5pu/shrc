# shellcheck shell=bash

# true (bool) if BASH greater or equal to 4
# sh as bash (3) exported functions are not seen as exported
# sh as bash (3) has arrays
# Exported arrays are not available in a new shell, but they are in a subshell
BASH4=false; [ "${BASH_VERSINFO[0]:-0}" -lt 4 ] || BASH4=true

set -o errtrace functrace

if $BASH4; then
    shopt -s inherit_errexit

    enable -f mypid enable_mypid
    enable -f truefalse false
    enable -f truefalse true
    for i in accept basename csv cut dirname dsv fdflags finfo getconf \
      head id ln logname mkdir mkfifo mktemp pathchk print printenv \
      push realpath rm rmdir seq setpgid sleep stat strftime sync tee tty uname unlink whoami; do
        enable -f "$i" "$i" 2>/dev/null
    done
fi
[ "${PS1-}" ] || return 0

# https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps
# CTRL+R -> history search, and CTRL+S -> history search backward
# $ sudo (I want to know completions .. CTRL+A CTRL+R CTRL+Y ... CTRL+R
stty -ixon

# https://zwischenzugs.com/2019/04/03/eight-obscure-bash-options-you-might-want-to-know-about/
#
shopt -s autocd cdable_vars checkwinsize dotglob execfail histappend nocaseglob nocasematch
! $BASH4 || shopt -s direxpand dirspell globstar progcomp_alias
