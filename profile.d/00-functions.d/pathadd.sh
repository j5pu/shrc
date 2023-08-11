# shellcheck shell=sh


#######################################
# # Prepend paths to PATH
# Globals:
#   PATH
# Arguments:
#   1
# Returns:
#   0 ...
#######################################
pathadd() {
  for arg; do
    test -d "${arg}" || continue
    case ":${PATH}:"  in
      *":${arg}:"*) continue ;;
    esac
    PATH="${arg}${PATH:+:"${PATH}"}"
  done
}