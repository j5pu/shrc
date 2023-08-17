# shellcheck shell=sh disable=SC2034,SC3028

# System-wide .profile for sh(1)
#

# Profile has been sourced to avoid sourcing again in user interactive shell
#
: "${SHRC_PROFILE_SOURCED=0}"
[ "${SHRC_PROFILE_SOURCED}" -eq 0 ] || return 0

# SHRC prefix where shrc repository is installed and other packages, dotfiles, etc.
#
: "${SHRC_PREFIX=${HOME}}"; export SHRC_PREFIX

# true (bool) if BASH greater or equal to 4
# sh as bash (3) exported functions are not seen as exported
# sh as bash (3) has arrays
# Exported arrays are not available in a new shell, but they are in a subshell
export BASH4=false; [ "${BASH_VERSINFO:-0}" -lt 4 ] || export BASH4=true
# Default user and Git User
#
export GIT="j5pu"
# brew prefix
#
export HOMEBREW_PREFIX="/usr/local"
# Short hostname
#
HOST="$(hostname -s)"; export HOST
# true if Darwin, false if Linux
#
export MACOS=true
# GitHub organization
#
export ORG="mnopi"
# BASE PATH
#
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# SHRC repository directory under $SHRC_PREFIX
#
export SHRC="${SHRC_PREFIX}/shrc"
# SHRC bin directory.
#
export SHRC_BIN="${SHRC}/bin"
# SHRC external completions compat directory. BASH_COMPLETION_USER_DIR
# "Dynamically loaded by __load_completion()/_completion_loader() functions,
# they add 'completions' to $BASH_COMPLETION_USER_DIR"
export SHRC_COMPLETION_D="${SHRC}/bash_completion.d"
# Application configurations that can be configured with global variables and do not contain secrets.
#
export SHRC_CONFIG="${SHRC}/config"
# SHRC DEBUG to 1 to show files etc.
#
: "${SHRC_DEBUG=0}"
# SHRC external custom dir for other repositories, completions and profile.d
# They are installed with "shrc install"
export SHRC_EXTERNAL="${SHRC}/external"
# SHRC external bin shims dir for other repositories
# Subdirectories are added to path
export SHRC_EXTERNAL_BIN="${SHRC_EXTERNAL}/bin"
# SHRC external completions compat directory. BASH_COMPLETION_USER_DIR
# "Dynamically loaded by __load_completion()/_completion_loader() functions,
# 3rd-party tools completions are installed manually under "vendor"
# Patched completions are installed under "patches"
export SHRC_EXTERNAL_COMPLETION_D="${SHRC_EXTERNAL}/bash_completion.d"
export BASH_COMPLETION_USER_DIR="${SHRC_EXTERNAL_COMPLETION_D}"
# SHRC external man shims dir for other repositories
# Subdirectories are added to manpath
export SHRC_EXTERNAL_MAN="${SHRC_EXTERNAL}/share/man"
# SHRC external custom dir for other repositories
#
export SHRC_EXTERNAL_PROFILE_D="${SHRC_EXTERNAL}/profile.d"
# SHRC generated color bin directory
#
export SHRC_GENERATED_COLOR="${SHRC}/color"
# SHRC files directory
#
export SHRC_FILES="${SHRC}/files"
# shrc shell for commands hooks (bash or zsh)
#
SHRC_HOOKS_SHELL="$(basename "${BASH:-${ZSH_NAME}}" | sed 's/^sh$/bash/')"; export SHRC_HOOKS_SHELL
# SHRC shell scripts sourcing libraries directory.
#
export SHRC_LIB="${SHRC}/lib"
# SHRC packages directory
#
export SHRC_PACKAGES="${SHRC}/packages"
# SHRC profile and system profile file
#
export SHRC_PROFILE="${SHRC}/profile"; export ENV="${SHRC_PROFILE}"
# SHRC profile compat directory
#
export SHRC_PROFILE_D="${SHRC}/profile.d"
# SHRC generated libraries in  profile compat directory
#
export SHRC_PROFILE_D_GENERATED_D="${SHRC_PROFILE_D}/99-generated.d"
# SHRC share.
#
export SHRC_SHARE="${SHRC}/share"
# Set to the shell name, if it is being sourced directly by a shell directly not script
# Helps when this is sourced by a script that completions are not sourced
SHELL_ARGZERO=""
case "${0##*/}" in
  -ash|ash|-bash|bash|busybox|-dash|dash|-ksh|ksh|-sh|sh|-zsh|zsh) SHELL_ARGZERO="$(echo "${0##*/}" | sed 's/^-//')"
esac
# sudo command path
#
SUDO="$(command -v sudo || true)"; export SUDO
# Darwin or Linux
#
UNAME="$(uname -s)"; export UNAME

if [ "${UNAME}" = "Darwin" ]; then
  unset PATH
  eval "$(/usr/libexec/path_helper -s)"
  export CLT="/Library/Developer/CommandLineTools"
  PATH="${PATH}:${CLT}/usr/bin"
else
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  export MACOS=false
fi

#######################################
# source files in arguments
# Arguments:
#  user     default $GIT or $USER
#######################################
source_files() {
  for arg; do
    if test -f "${arg}"; then
      [ "${SHRC_DEBUG}" -eq 0 ] || echo "${arg}"
      . "${arg}"
    fi
done
}

# source: posix (common to all shells)
#
source_files "${SHRC_PROFILE_D}"/??*.d/*.sh "${SHRC_PROFILE_D}"/??*.sh "${SHRC_PROFILE_D}/${UNAME}.d"/*.d/*.sh

# source: bash and zsh hooks
#
if [ "${SHRC_HOOKS_SHELL-}" ]; then
  source_files "${SHRC_PROFILE_D}"/??*.d/*."${SHRC_HOOKS_SHELL}" \
    "${SHRC_PROFILE_D}"/??*."${SHRC_HOOKS_SHELL}" \
    "${SHRC_PROFILE_D}/${UNAME}.d"/*.d/*."${SHRC_HOOKS_SHELL}"
fi

source_files_if_bash4_and_ps1 "${SHRC_COMPLETION_D}"/**/*

! cmd export_all_functions || export_all_functions

SHRC_PROFILE_SOURCED=1
