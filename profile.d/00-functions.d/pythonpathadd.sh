# shellcheck shell=sh

#######################################
# # Prepend paths to PYTHONPATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
pythonpathadd() {
  for arg; do
    test -d "${arg}" || continue
    case ":${PYTHONPATH}:" in
       *":${arg}:"*) continue ;;
    esac
    export PYTHONPATH="${arg}${PYTHONPATH:+:"${PYTHONPATH}"}"
  done
}
