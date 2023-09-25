# shellcheck shell=sh

# Git Repository Top Path if exist for cd_top() and cd_top_exit()
#
export GIT_TOP=""

#######################################
# activate venv
#######################################
activate() {
  test -d venv || return 0
  . venv/bin/activate
}

#######################################
# # Prepend paths to INFOPATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
addinfopath() {
  for arg; do
    test -d "${arg}" || continue
    case ":${INFOPATH}:"  in
      *":${arg}:"*) continue ;;
    esac
    export INFOPATH="${arg}${INFOPATH:+:"${INFOPATH}"}"
  done
}

#######################################
# # Prepend paths to MANPATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
addmanpath() {
  for arg; do
    test -d "${arg}" || continue
    case ":${MANPATH}:" in
       *":${arg}:"*) continue ;;
    esac
    export MANPATH="${arg}:${MANPATH:+"${MANPATH}"}"
  done
}

#######################################
# # Prepend paths to PATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
addpath() {
  for arg; do
    test -d "${arg}" || continue
    case ":${PATH}:"  in
      *":${arg}:"*) continue ;;
    esac
    PATH="${arg}${PATH:+:"${PATH}"}"
  done
}

#######################################
# # Prepend paths to PYTHONPATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
addpythonpath() {
  for arg; do
    test -d "${arg}" || continue
    case ":${PYTHONPATH}:" in
       *":${arg}:"*) continue ;;
    esac
    export PYTHONPATH="${arg}${PYTHONPATH:+:"${PYTHONPATH}"}"
  done
}

#######################################
# check if command exits
# Arguments:
#  command
#######################################
cmd() { command -v "${1}" >/dev/null; }

#######################################
# change to git repository top path
# Arguments:
#  None
# Returns:
#   1 if not git repository
#######################################
cd_top() {
  if GIT_TOP="$(git rev-parse --show-toplevel 2>&1)"; then
    cd "${GIT_TOP}" || return 1
    return
  else
    >&2 echo "cd_top: ${PWD}: ${GIT_TOP}"
    GIT_TOP=""
    return 1
  fi
}

#######################################
# change to git repository top path and exit if not git repository
# Arguments:
#  None
# Returns:
#   1 if not git repository (exit)
#######################################
cd_top_exit() { cd_top || exit; }


#######################################
# generate cd aliases
# Globals:
#   SHRC_PROFILE_SOURCED
# Arguments:
#   None
#######################################
generate_aliases() {
  ! test -f "${SHRC_PROFILE_D_GENERATED_D}/alias.sh" || return 0

  _aliases_directories="${DEFAULT_HOME}"
  _aliases_tmp="$(mktemp)"

  for _aliases_directory in "${DEFAULT_HOME}/Archive" "${DEFAULT_HOME}/Documents" /Volumes; do
    ! test -d "${_aliases_directory}" || _aliases_directories="${_aliases_directories} ${_aliases_directory}"
  done


  {
    echo '# shellcheck shell=sh'
    echo
    # shellcheck disable=SC2016
    echo '{ [ "${PS1-}" ] && [ "${SH_ARGZERO-}" ] && [ "${SH_HOOK-}" ]; }'
    echo
  } > "${SHRC_PROFILE_D_GENERATED_D}/alias.sh"

  {    # shellcheck disable=SC2086
    q="'" find -L ${_aliases_directories} -type d -mindepth 1 -maxdepth 1 -not \( -name ".git" -o -name ".idea" \) \
      -exec sh -c 'v="$(echo "${1##*/}" | sed "s/ //g;s/(//g;s/)//g")"; echo alias .${v}=${q}cd \"$1\"$q' sh {} \;

    if $MACOS; then
      for _aliases_directory in "Application Support" LaunchAgents Preferences; do
        echo "alias .$(echo "${_aliases_directory}" \
          | sed "s/ //g")='cd \"${DEFAULT_HOME}/Library/${_aliases_directory}\"'"
      done
    fi
  } > "${_aliases_tmp}"

  sort -u "${_aliases_tmp}" >> "${SHRC_PROFILE_D_GENERATED_D}/alias.sh"

  . "${SHRC_PROFILE_D_GENERATED_D}/alias.sh"

  unset _aliases_directories _aliases_directory
}


#######################################
# generate cd aliases
# Globals:
#   SHRC_PROFILE_SOURCED
# Arguments:
#   None
#######################################
generate_sudo() {
  { ! test -f "${SHRC}/sudo/apt" && [ "${SUDO-}" ]; }  || return 0
  mkdir -p "${SHRC}/sudo"

  for _sudo_command in \
    a2dismod a2dismode a2dissite a2enmod a2enmode a2ensite add-apt-repository addgroup adduser apache2 apache2ctl\
    apachectl apt apt-add-repository apt-cache apt-file apt-get aptitude AssetCacheManagerUtil automysqlbackup \
    certbot chattr chflags chgrp chkrootkit chmod chown configure-debian cubic \
    date dd debconf debconf-set-selections debi debuild delgroup deluser depmod df dhclient dig diskutil dkms dlocate \
    dmesg dnstop dpkg dpkg-reconfigure dpkg-source drill dscacheutil dscl du \
    fail2ban fail2ban-client fdisk fkill flatpak fsck fuser getent gparted grub-mkconfig \
    hostnamectl htpasswd hwclock \
    ifconfig ip iptables iptables_save iw \
    journalctl \
    kextload kill killall \
    locale-gen locate losetup lsblk lshw lsof lspci lsusb lvdisplay \
    make-kpkg mdfind mkfs mkfs.ext4 mkpasswd modprobe mount mtr \
    mysql mysql_secure_installation mysql_upgrade mysqld_safe mysqldump \
    nc ncat netfilter-persistent netplan netstat networkctl networksetup nginx nield nmap nmcli nping nslookup \
    openvpn opkg \
    parted partprobe partx pecl phpdismod phpenmod ping pkill polo-disk postfix poweroff pre-up pvscan \
    qemu-nbd \
    reboot rkhunter rmmod rndc route \
    scutil service smartctl software-properties-gtk softwareupdate spctl ss \
    swapoff swapon sysctl systemd-analyze systemd-resolve sysupgrade \
    tasksel tcpdump tcptrack telnet tmutil traceroute trash \
    udevadm ufw umount unbound-anchor unbound-host \
    update-alternatives update-grub update-grub2 update-locale update-manager update-rc.d updatedb useradd usermod \
    vgchange vgscan \
    wg wg-quick whois wpa_passphrase wpa_supplicant \
    xattr \
    zenmap; do

      if $MACOS; then
        case "${_sudo_command}" in
          apt|updatedb) continue ;;
        esac
      fi

      if cmd "${_sudo_command}"; then
        {
          echo "#!/bin/sh"
          echo
          echo "${SUDO} $(command -pv "${_sudo_command}") \"\$@\""
        } > "${SHRC}/sudo/${_sudo_command}"

        /bin/chmod +x "${SHRC}/sudo/${_sudo_command}"
      fi
  done

  unset _sudo_command
}

#######################################
# has alias, command or function (uses type)
# Arguments:
#   1   alias, command or function name
# Returns:
#   1   parameter null or not set
#######################################
has() { type "$@" 1>/dev/null 2>&1; }

#######################################
# command or commands exists
# Arguments:
#  command [command]    command or commands
# Returns:
#  1 if any of the command does not exist
#######################################
hasall() {
  _help="$(cat <<EOF
usage: hasall [command...]
       . utils.sh; hasall [function...]
       hasall [-h|--help|help]

command, builtin, function, alias exists (uses 'type')

Arguments:
  [command...]          command, builtin and function or alias when sourced

Commands:
   -h, --help, help     display this help and exit.

Returns:
   1 if at least one of commands does not exist
EOF
)"
  if test $# -eq 0; then
    echo "${_help}"; exit 1
  else
    case "$1" in
      -h|--help|help) echo "${_help}"; return 0 ;;
    esac
  fi

  if [ $# -eq 1 ]; then
    type "$1" >/dev/null 2>&1
  else
    tmp="$(mktemp)"
    type "$@" >/dev/null 2>"${tmp}"
    ! test -s "${tmp}" || grep -qv "not found" "${tmp}"
  fi
}

#######################################
# check is running configuration or running in jetbrains terminal and sets project super top variable
# Globals:
#   JEDI_TOP
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
isjedi() {
  [ "${TERMINAL_EMULATOR-}" = "JetBrains-JediTerm" ] || [ "${TTY-}" = "not a tty" ] || $INTELLIJ || return
  # Set to top level of project if running in run or in jediterm
  #
  export JEDI_TOP
  JEDI_TOP="$(git superproject)"
}

#######################################
# add/prepend directory to variable (PATH, MANPATH, etc.) removing previous entries
# Globals:
#   PATH
# Arguments:
#   1   directory to add
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_add() {
  path_pop "${1:-${PWD}}" "${2-}"
  _path_add_value="$(eval echo "\$${2:-PATH}")"
  _path_add_value="${_path_add_value:+:${_path_add_value}}"
  [ "${2:-PATH}" != "MANPATH" ] || [ "${_path_add_value-}" ] || _path_add_value=":"
  _path_add_real="$(pwd_p "${1:-${PWD}}" 2>/dev/null)"
  eval "export ${2:-PATH}='${_path_add_real}${_path_add_value}'"
  unset _path_add_value _path_add_real
}

#######################################
# add/prepend dir/sbin:dir/bin:dir/libexec, dir/share/info and dir/share/man removing previous entries
# Globals:
#   PATH
# Arguments:
#   1   directory
# Returns:
#   1   parameter null or not set
#######################################
path_add_all() {
  for _path_add_all in libexec bin sbin; do
    path_add "${1:-${PWD}}/${_path_add_all}"
  done
  path_add "${1:-${PWD}}/share/man" MANPATH
  path_add "${1:-${PWD}}/share/info" INFOPATH
  unset _path_add_all
}

#######################################
# add/prepend directory to variable (PATH, MANPATH, etc.) removing previous entries if directory exists
# Arguments:
#   1   directory to add
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_add_exist() { path_pop "${1:-${PWD}}" "${2-}"; [ ! -d "${1:-${PWD}}" ] || path_add "${1:-${PWD}}" "${2-}"; }

#######################################
# add/prepend dir/sbin:dir/bin:dir/libexec, dir/share/info and dir/share/man removing previous entries if exist
# Globals:
#   PATH
# Arguments:
#   1   directory
# Returns:
#   1   parameter null or not set
#######################################
path_add_exist_all() {
  for _path_add_exist_all in libexec bin sbin; do
    path_add_exist "${1:-${PWD}}/${_path_add_exist_all}"
  done
  path_add_exist "${1:-${PWD}}/share/man" MANPATH
  path_add_exist "${1:-${PWD}}/share/info" INFOPATH
  unset _path_add_exist_all
}

#######################################
# append directory to variable (PATH, MANPATH, etc.) removing previous entry
# Arguments:
#   1   directory to append
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_append() {
  path_pop "${1:-${PWD}}" "${2-}"
  _path_append_value="$(eval echo "\$${2:-PATH}")"
  if [ "${2:-PATH}" = "MANPATH" ]; then
    _path_append_last=":"
  elif [ "${_path_append_value-}" ]; then
    _path_append_first=":"
  fi
  _path_append_real="$(pwd_p "${1:-${PWD}}" 2>/dev/null)"
  eval "export ${2:-PATH}='${_path_append_value}${_path_append_first-}${_path_append_real}${_path_append_last-}'"
  unset _path_append_first _path_append_last _path_append_real _path_append_value
}

#######################################
# append directory to variable (PATH, MANPATH, etc.) removing previous entry
# Arguments:
#   1   directory to append
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_append_exist() { path_pop "${1:-${PWD}}" "${2-}"; [ ! -d "${1:-${PWD}}" ] || path_append "${1:-${PWD}}" "${2-}"; }

#######################################
# remove duplicates from variable (PATH, MANPATH, etc.)
# Arguments:
#   1   variable name (default: PATH)
#######################################
path_dedup() {
  [ "${1:-PATH}" = "MANPATH" ] || _path_dedup_strip=":"
  _path_dedup_value="$(eval echo "\$${1:-PATH}" |  tr ':' '\n' | awk '!NF || !seen[$0]++' | \
    sed -n "H;\${x;s|\n|:|g;s|^:||;s|${_path_dedup_strip-}$||;p;}")"
  [ "${_path_dedup_value}" != ":" ] || _path_dedup_value=""
  eval "export ${1:-PATH}='${_path_dedup_value}'"
  unset _path_dedup_strip _path_dedup_value
}

#######################################
# is directory in variable (PATH, MANPATH, etc.)
# Globals:
#   PATH
# Arguments:
#   1   directory to check
#   2   variable name (default: PATH)
# Returns:
#   0 if directory in $PATH
#   1 if directory not in $PATH, parameter null or parameter not set
#######################################
path_in() {
  [ "${2:-PATH}" = "MANPATH" ] || _path_in_add=":"
  _path_in_real="$(pwd_p "${1:-${PWD}}" 2>/dev/null)"
  case ":$(eval echo "\$${2:-PATH}")${_path_in_add-}" in
    *:"${_path_in_real}":*) unset _path_in_add _path_in_real; return 0 ;;
    *) unset _path_in_add _path_in_real; return 1 ;;
  esac
}

#######################################
# removes directory from variable (PATH, MANPATH, etc.)
# Globals:
#   PATH
# Arguments:
#   1   directory to remove
#   2   variable name (default: PATH)
# Returns:
#   1   parameter null or not set
#######################################
path_pop() {
  [ "${2:-PATH}" = "MANPATH" ] || _path_pop_strip=":"
  _path_pop_real="$(pwd_p "${1:-${PWD}}" 2>/dev/null)"
  # FIXME: bats gives error "grep: brackets ([ ]) not balanced" when calling bats::env
  _path_pop_value="$(eval echo "\$${2:-PATH}" | sed 's/:$//' | tr ':' '\n' | \
    grep -v "^${_path_pop_real}$" | tr '\n' ':' | sed "s|${_path_pop_strip-}$||")"
  [ "${_path_pop_value}" != ":" ] || _path_pop_value=""
  eval "export ${2:-PATH}='${_path_pop_value}'"
  unset _path_pop_real _path_pop_strip _path_pop_value
}

#######################################
# prompt title
# Globals:
#   SHRC_PROFILE_SOURCED
# Arguments:
#   None
#######################################
prompt_title() { prompt title; }

#######################################
# rebash
# Globals:
#   SHRC_PROFILE_SOURCED
# Arguments:
#   None
#######################################
rebash() {
  unset SHRC_PROFILE_SOURCED && rm -rf "${SHRC_PROFILE_D_GENERATED_D}/alias.sh" "${SHRC}/sudo/"* && . /etc/profile
}

#######################################
# source directory using find instead of globs
# Arguments:
#   None
#######################################
source_dir() {
  test -n "$(find "$1" \( -type f -or -type l \) -not -name ".*")" || return 0
  for _rc_source in "$1"/*; do
    case "${_rc_source##*/}" in
      .DS_Store | .gitkeep | .keep | .localized) continue ;;
    esac
    . "${_rc_source}"
  done

  unset _rc_source
}

#######################################
# source files if bash4 and interactive, i.e.: completions
# Arguments:
#  user     default $GIT or $USER
#######################################
source_files_if_bash4_and_ps1() { ! $BASH4 || [ ! "${PS1-}" ] || source_files "$@"; }
