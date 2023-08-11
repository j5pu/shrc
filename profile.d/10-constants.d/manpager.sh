# shellcheck shell=sh

if cmd most; then
  export MANPAGER=most
else
  export MANPAGER=less
fi
