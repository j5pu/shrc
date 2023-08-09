# shellcheck shell=bash

# true (bool) if BASH greater or equal to 4
# sh as bash (3) exported functions are not seen as exported
# sh as bash (3) has arrays
# Exported arrays are not available in a new shell, but they are in a subshell
BASH4=false
[ "${BASH_VERSINFO[0]:-0}" -lt 4 ] || BASH4=true

set -o errtrace functrace

if $BASH4; then
  shopt -s inherit_errexit

  enable -f mypid enable_mypid
  enable -f truefalse false
  enable -f truefalse true
  for i in accept csv dsv fdflags finfo \
    id logname mkfifo mktemp pathchk print printenv \
    push setpgid sleep strftime sync tee tty whoami; do
    enable -f "$i" "$i" 2>/dev/null
  done
fi
[ "${PS1-}" ] || return 0

# https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps
# CTRL+R -> history search, and CTRL+S -> history search backward
# $ sudo (I want to know completions .. CTRL+A CTRL+R CTRL+Y ... CTRL+R
# Be aware that, in many terminals, the CTRL + S combination is mapped to suspend the terminal session.
# This will intercept any attempts to pass CTRL + S to bash, and will “freeze” your terminal.
# To unfreeze, type CTRL + Q to unsuspend the session.
#
# This suspends and resume feature is not needed in most modern terminals,
# and you can turn it off without any problem by running the following commandBe aware that,
# in many terminals, the CTRL + S combination is mapped to suspend the terminal session.
# This will intercept any attempts to pass CTRL + S to bash, and will “freeze” your terminal.
# To unfreeze, type CTRL + Q to unsuspend the session.
#
# This suspends and resume feature is not needed in most modern terminals,
# and you can turn it off without any problem by running the following command
stty -ixon 2>/dev/null  # stty: stdout appears redirected, but stdin is the control descriptor

# https://zwischenzugs.com/2019/04/03/eight-obscure-bash-options-you-might-want-to-know-about/
#
shopt -s cdable_vars checkwinsize dotglob execfail histappend nocaseglob nocasematch
! $BASH4 || shopt -s autocd direxpand dirspell globstar progcomp_alias
