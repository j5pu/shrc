# shellcheck shell=sh

# System-wide .profile for sh(1)
#

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

cmd() { command -v "${1}" >/dev/null; }
source_files() { for arg; do ! test -f "${arg}" || . "${arg}"; done; }

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

export_all_functions

export ENV="${SHRC_PROFILE}"
