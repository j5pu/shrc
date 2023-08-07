# shellcheck shell=sh

_shell="$(command -v bash)"
[ "${_shell}" != "$(dscl . -read "/Users/${USER}" UserShell | awk '{ print $2 }')" ] || { unset _shell; return 0; }
sudo dscl . -create "/Users/${USER}" UserShell "${_shell}"
unset _shel
