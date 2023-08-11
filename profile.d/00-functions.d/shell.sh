# shellcheck shell=sh disable=SC2034

#
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

#######################################
# get running shell
# Arguments:
#  1    shell executable
#######################################
shell() {
  #######################################
  # bash
  # Arguments:
  #  None
  #######################################
  # shellcheck disable=SC3044,SC3040,SC3028,SC3054
  __bash() {
    SH="${BASH##*/}"
    # shellcheck disable=
    [ "${BASH_VERSINFO[0]}" -lt 4 ] || { SH="bash4"; BASH4=true; }
  }

  #######################################
  # real path of shell
  # Arguments:
  #  1    shell executable
  #######################################
  __real() {
    SH="$("$(command -v realpath || command -v readlink)" "$(command -v "$1")")"
    [ "${SH-}" ] || SH="$1"
    SH="posix-${SH##*/}"
  }

  # true (bool) if BASH greater or equal to 4
  # sh as bash (3) exported functions are not seen as exported
  # sh as bash (3) has arrays
  # Exported arrays are not available in a new shell, but they are in a subshell
  BASH4=false

  # <html><h2>Running Shell</h2>
  # <p><strong><code>$SH</code></strong> posix-<ash|busybox|dash|ksh|sh>, zsh, sh for bash sh, bash or bash4.</p>
  # </html>
  SH="${ZSH_ARGZERO:-${0##*/}}"

  # true (bool) if sourced or running in ZSH false if not
  #
  ZSH=false

  case "${SH}" in
    -ash|ash|-bash|bash|-busybox|busybox|-dash|dash|-ksh|ksh|-sh|sh)
      if [ "${BASH_SOURCE-}" ]; then
        __bash
      else
        __real "${ZSH_ARGZERO:-$0}"
      fi
      ;;
    -zsh|zsh) SH="zsh"; ZSH=true ;;
    *)
      if [ "${BASH-}" ]; then
        __bash
      elif [ "${ZSH_EVAL_CONTEXT-}" ]; then
        SH="zsh"; ZSH=true
      elif [ "${KSH_VERSION-}" ]; then
        SH="posix-ksh"
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

  # Hook for shell-specific initialization (zsh or bash).
  #
  SH_HOOK="$(echo "${SH}" | sed -E 's/(posix-.*|4|^sh$)//')"

  unset -f __bash __real
  unset __ps
}
