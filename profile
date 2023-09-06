# shellcheck shell=sh

# System-wide .profile for sh(1)
#

# Profile has been sourced to avoid sourcing again in user interactive shell
#
: "${SHRC_PROFILE_SOURCED=0}"
[ "${SHRC_PROFILE_SOURCED}" -eq 0 ] || return 0

# SHRC prefix where shrc repository is installed and other packages, dotfiles, etc.
#
: "${SHRC_PREFIX=${HOME}}"; export SHRC_PREFIX

# Default user and Git User
#
export GIT="j5pu"
# Default user home
#
DEFAULT_HOME="$(eval echo ~"${GIT}")"; test -d "${DEFAULT_HOME}" || DEFAULT_HOME="${HOME}"; export DEFAULT_HOME
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
export SHRC_EXTERNAL_BIN="${SHRC_EXTERNAL}/bin"; mkdir -p "${SHRC_EXTERNAL_BIN}"
# SHRC external completions compat directory. BASH_COMPLETION_USER_DIR
# "Dynamically loaded by __load_completion()/_completion_loader() functions,
# 3rd-party tools completions are installed manually under "vendor"
# Patched completions are installed under "patches"
export SHRC_EXTERNAL_COMPLETION_D="${SHRC_EXTERNAL}/bash_completion.d"; mkdir -p "${SHRC_EXTERNAL_COMPLETION_D}"
export BASH_COMPLETION_USER_DIR="${SHRC_EXTERNAL_COMPLETION_D}"
# SHRC external man shims dir for other repositories
# Subdirectories are added to manpath
export SHRC_EXTERNAL_MAN="${SHRC_EXTERNAL}/share/man"; mkdir -p "${SHRC_EXTERNAL_MAN}"
# SHRC external custom dir for other repositories
#
export SHRC_EXTERNAL_PROFILE_D="${SHRC_EXTERNAL}/profile.d"; mkdir -p "${SHRC_EXTERNAL_PROFILE_D}"
# SHRC generated color bin directory
#
export SHRC_GENERATED_COLOR="${SHRC}/color"
# SHRC files directory
#
export SHRC_FILES="${SHRC}/files"
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
# Forces SHRC prompt even if starship or zsh prompt are configured
#
: "${SHRC_PROMPT=0}"; export SHRC_PROMPT
# SHRC share.
#
export SHRC_SHARE="${SHRC}/share"
# sudo command path
#
SUDO="$(! test -x /usr/bin/sudo || echo /usr/bin/sudo)"; export SUDO
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
# get running shell
# Running shell
# https://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# https://man7.org/linux/man-pages/man1/sh.1p.html
# https://man7.org/linux/man-pages/man1/dash.1.html
# https://linux.die.net/man/1/ksh
# https://www.mkssoftware.com/docs/man1/sh.1.asp
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
# BASH:
# /bin/bash or bash does not look at $ENV
# /bin/sh uses $ENV
# sudo su (with SHELL /bin/sh) uses $ENV
# Ideally .bashrc, although if I log in and no vars depending on the user...
# Arguments:
#  1    shell executable
#######################################
shell() {
  # true (bool) if BASH greater or equal to 4
  # sh as bash (3) exported functions are not seen as exported
  # sh as bash (3) has arrays
  # Exported arrays are not available in a new shell, but they are in a subshell
  BASH4=false

  # <html><h2>Running Shell</h2>
  # <p><strong><code>$SH</code></strong> ash|bash|busybox|dash|ksh|sh|sh for bash sh|zsh.</p>
  # </html>
  SH="${ZSH_ARGZERO:-${0##*/}}"

  # Set to the shell name, if it is being sourced directly by a shell directly not script
  # ash, bash, busybox, dash, ksh, sh, zsh or "" if not sourced by a shell directly.
  # Helps when this is sourced by a script that completions are not sourced
  SH_ARGZERO=""

  # shell for commands hooks: bash (bash for bash sh), zsh or ""
  #
  SH_HOOK=""

  # shell to source libs: bash4, bash (bash for bash sh), zsh or sh
  #
  SH_SOURCE="sh"

  # true (bool) if sourced or running in ZSH false if not
  #
  ZSH=false

  #######################################
  # bash
  # Arguments:
  #  None
  #######################################
  # shellcheck disable=SC3044,SC3040,SC3028,SC3054
  __bash() {
    SH="${BASH##*/}"
    SH_HOOK="bash"
    SH_SOURCE="bash"

    set -o errtrace functrace

    if [ "${BASH_VERSINFO:-0}" -lt 4 ]; then
      # Shared array to copy array used by cparray(), getkey(), getvalue() and inarray()
      #
      declare -ax _ARRAY
    else
      # Shared array to copy array used by cparray(), getkey(), getvalue() and inarray()
      #
      declare -Ax _ARRAY

      BASH4=true
      SH_SOURCE="bash4"

      # ls ./* does not expand .*, that is dotglob)
      # ls ./* does not give error if no files, that is failglob)
      shopt -s inherit_errexit extglob globstar gnu_errfmt

      enable -f mypid enable_mypid
      enable -f truefalse false
      enable -f truefalse true
      for i in accept csv dsv fdflags finfo \
        id logname mkfifo mktemp pathchk printenv \
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
  }

  #######################################
  # real path of shell
  # Arguments:
  #  1    shell executable
  #######################################
  __real() {
    SH="$("$(command -v realpath || command -v readlink)" "$(command -v "$1")")"
    [ "${SH-}" ] || SH="$1"
    SH="${SH##*/}"
  }

  case "${SH}" in
    -ash|ash|-bash|bash|-busybox|busybox|-dash|dash|-ksh|ksh|-sh|sh)
      SH_ARGZERO="$(echo "${0##*/}" | sed 's/^-//')"
      if [ "${BASH_SOURCE-}" ]; then
        __bash
      else
        __real "${ZSH_ARGZERO:-$0}"
      fi
      ;;
    -zsh|zsh) SH="zsh"; SH_ARGZERO="zsh"; SH_HOOK="zsh"; SH_SOURCE="zsh"; ZSH=true ;;
    *)
      if [ "${BASH-}" ]; then
        __bash
      elif [ "${ZSH_EVAL_CONTEXT-}" ]; then
        SH="zsh"; SH_HOOK="zsh"; SH_SOURCE="zsh"; ZSH=true
      elif [ "${KSH_VERSION-}" ]; then
        SH="ksh"
      else
        if test -f /proc/$$/comm; then
          SH="$(cat /proc/$$/comm)"
          __exe="$(awk -F '[()]' '{ print $2 }' /proc/$$/stat)"
          __cmd="$(tr "\000" "\n" < /proc/$$/cmdline | head -1)"
          [ "${__exe##*/}" = "${__cmd##*/}" ] || SH="${__cmd}"
        elif __ps="$(command -v ps)"; then
          SH="$("${__ps}" -o pid= -o comm= | command sed -n "s/^ \{0,\}$$ //p")"
        fi
        case "${SH##*/}" in
          ash|busybox|dash|sh) __real "${SH#-}" ;;
        esac
      fi
      ;;
  esac

  unset -f __bash __real
  unset __ps
}
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

shell

for __file in $(printf "%s\n" \
  "${SHRC_PROFILE_D}"/??*.sh "${SHRC_PROFILE_D}"/??*."${SH_HOOK}" "${SHRC_PROFILE_D}"/??*."${SH_SOURCE}" \
  "${SHRC_PROFILE_D}"/??*.d/*.sh "${SHRC_PROFILE_D}"/??*.d/*."${SH_HOOK}" "${SHRC_PROFILE_D}"/??*.d/*."${SH_SOURCE}" \
  "${SHRC_PROFILE_D}/${UNAME}"*.sh "${SHRC_PROFILE_D}/${UNAME}"*."${SH_HOOK}" "${SHRC_PROFILE_D}/${UNAME}"*."${SH_SOURCE}" \
  "${SHRC_PROFILE_D}/${UNAME}.d"/**/*.sh \
  "${SHRC_PROFILE_D}/${UNAME}.d"/**/*."${SH_HOOK}" \
  "${SHRC_PROFILE_D}/${UNAME}.d"/**/*."${SH_SOURCE}" \
  | sort -u); do
  source_files "${__file}"
done
unset __file

SHRC_PROFILE_SOURCED=1
