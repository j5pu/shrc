# shellcheck shell=bash

# ls ./* does not expand .*, that is dotglob)
# ls ./* does not give error if no files, that is failglob)

set -o errtrace functrace

if $BASH4; then
  shopt -s inherit_errexit extglob globstar gnu_errfmt

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
shopt -s cdable_vars cdspell checkwinsize histappend progcomp
! $BASH4 || shopt -s autocd direxpand dirspell progcomp_alias
