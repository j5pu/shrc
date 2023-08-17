# shellcheck shell=bash


_shell="$(command -v bash)"
[ "${_shell}" != "$(awk -F: -v user="${USER}" '$1 == user {print $NF}' /etc/passwd)" ] || { unset _shell; return 0; }
"${SUDO}" chsh -s "${_shell}" 2>/dev/null
unset _shell
