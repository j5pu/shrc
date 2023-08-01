# shellcheck shell=sh

set +x
unset ENV

export GIT="j5pu"
export ORG="mnopi"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
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
# SHRC profile and system profile file
#
export SHRC_PROFILE="${SHRC}/profile";
# SHRC profile compat directory
#
export SHRC_PROFILE_D="${SHRC}/profile.d";

cmd() { command -v "${1}" >/dev/null; }
source_files() {
  for arg; do
    ! test -f "${arg}" || . "${arg}"
  done
 }

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
source_file "${SECRETS}"

# source: homebrew profile.d
#
! test -d "${HOMEBREW_PREFIX}/etc/profile.d" || source_files "${HOMEBREW_PREFIX}/etc/profile.d"/*

export_all_functions

export ENV="${SHRC_PROFILE}"

set +x
