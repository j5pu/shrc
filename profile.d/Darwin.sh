# shellcheck shell=bash

# HACER: /etc/shells

export LIBRARY="${DEFAULT_HOME}/Library"
export MOBILE="${LIBRARY}/Mobile Documents"
export ICLOUD="${MOBILE}/com~apple~CloudDocs"

# At the bottom
_shell="$(command -v bash)"
[ "${_shell}" != "$(dscl . -read "/Users/${USER}" UserShell | awk '{ print $2 }')" ] || { unset _shell; return 0; }
sudo dscl . -create "/Users/${USER}" UserShell "${_shell}"
sudo chsh -s "${_shell}" 2>/dev/null
unset _shell
