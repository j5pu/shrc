# shellcheck shell=zsh

#
# Utils Library for ZSH

# Functions:
#   sh(as bash) and bash exported functions are seen when exported in subshells and new shells
#   zsh: functions exported are available in subshells (no need to export them) but not in a new shell
# Arrays:
#   sh(as bash)/bash/zsh: exported arrays are not available in a new shell, but they are in a subshell

# RC: utils.zsh has been sourced already
#
: "${_RC_UTILS_ZSH_SOURCED=0}"
[ "${_RC_UTILS_ZSH_SOURCED}" -eq 0 ] || return 0

####################################### ZSH
#
$ZSH || return 0
! has zsh_bashcompinit || return 0

#######################################
# bash completions in zsh
# Arguments:
#  None
#######################################
zsh_bashcompinit() { ! has autoload || has bashcompinit || { autoload -U +X bashcompinit && bashcompinit; }; }

_RC_UTILS_ZSH_SOURCED=1

echo "BASH4: $BASH4, RC: ${RC}, SH: $SH, SH_HOOK: ${SH_HOOK}, ZSH: $ZSH"
