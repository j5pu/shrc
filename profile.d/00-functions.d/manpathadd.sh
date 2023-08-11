# shellcheck shell=sh

#######################################
# # Prepend paths to MANPATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
manpathadd() {
  for arg; do
    test -d "${arg}" || continue
    case ":${MANPATH}:" in
       *":${arg}:"*) continue ;;
    esac
    export MANPATH="${arg}:${MANPATH:+"${MANPATH}"}"
  done
}