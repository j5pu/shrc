# shellcheck shell=sh

#######################################
# # Prepend paths to INFOPATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
infopathadd() {
  for arg; do
    test -d "${arg}" || continue
    case ":${INFOPATH}:"  in
      *":${arg}:"*) continue ;;
    esac
    export INFOPATH="${arg}${INFOPATH:+:"${INFOPATH}"}"
  done
}