# shellcheck shell=sh

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

