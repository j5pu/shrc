# shellcheck shell=sh

# System-wide .profile for sh(1)
#

# Profile has been sourced to avoid sourcing again in user interactive shell
#
: "${SHRC_PROFILE_SOURCED=0}"
[ "${SHRC_PROFILE_SOURCED}" -eq 0 ] || return

unset ENV

#######################################
# check if command exits
# Arguments:
#  command
#######################################
cmd() { command -v "${1}" >/dev/null; }
#######################################
# source files in arguments
# Arguments:
#  user     default $GIT or $USER
#######################################
source_files() { for arg; do ! test -f "${arg}" || . "${arg}"; done; }
#######################################
# get user home
# Arguments:
#  user     default $GIT or $USER
#######################################
home() { ${SUDO:+${SUDO} -u} "${1-${GIT}}" sh -c 'echo "${HOME}"'; }


# sudo command path
#
SUDO="$(command -v sudo || true)"; export SUDO
# Default user and Git User
#
export GIT="j5pu"
# Default user home to install or development
#
export DEFAULT_HOME="$(home)"
# brew prefix
#
: "${HOMEBREW_PREFIX=/usr/local}"; export HOMEBREW_PREFIX
# Short hostname
#
export HOST="$(hostname -s)"
# true if Darwin, false if Linux
#
export MACOS=true
# GitHub organization
#
export ORG="mnopi"
# BASE PATH
#
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# Secrets repository path
#
export SECRETS="/Users/${GIT}/secrets/secrets.sh"
# SHRC root
#
: "${SHRC=/Users/${GIT}/shrc}"; export SHRC
# Application configurations that can be configured with global variables and do not contain secrets.
#
export SHRC_CONFIG="${SHRC}/config"
# shrc shell for commands hooks (bash or zsh)
#
SHRC_HOOKS_SHELL="$(basename "${BASH:-${ZSH_NAME}}" | sed 's/^sh$/bash/')"; export SHRC_HOOKS_SHELL
# SHRC packages directory
#
export SHRC_PACKAGES="${SHRC}/packages";
# SHRC profile and system profile file
#
export SHRC_PROFILE="${SHRC}/profile";
# SHRC profile compat directory
#
export SHRC_PROFILE_D="${SHRC}/profile.d";
# SHRC generated libraries in  profile compat directory
#
export SHRC_PROFILE_D_GENERATED_D="${SHRC_PROFILE_D}/99-generated.d";
# Darwin or Linux
#
UNAME="$(uname -s)"; export UNAME

if [ "${UNAME}" = "Darwin" ]; then
  unset PATH; eval "$(/usr/libexec/path_helper -s)"
  export CLT="/Library/Developer/CommandLineTools"
  PATH="${PATH}:${CLT}/usr/bin"
else
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  MACOS=false
fi

# source: posix (common to all shells)
#
source_files "${SHRC_PROFILE_D}"/??-*/*.sh

# source: bash and zsh hooks
#
[ ! "${SHRC_HOOKS_SHELL-}" ] || source_files "${SHRC_PROFILE_D}"/??-*/*."${SHRC_HOOKS_SHELL}"

# source: Darwin and Linux (UNAME)
#
! test -d "${SHRC_PROFILE_D}/${UNAME}.d" || source_files "${SHRC_PROFILE_D}/${UNAME}.d"/*.sh

# source: secrets
#
source_files "${SECRETS}"

# source: homebrew profile.d
#
! test -d "${HOMEBREW_PREFIX}/etc/profile.d" || source_files "${HOMEBREW_PREFIX}/etc/profile.d"/*

! cmd export_all_functions || export_all_functions

export ENV="${SHRC_PROFILE}"
SHRC_PROFILE_SOURCED=1