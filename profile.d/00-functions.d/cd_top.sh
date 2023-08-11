# shellcheck shell=sh

# Git Repository Top Path if exist for cd_top() and cd_top_exit()
#
export GIT_TOP=""

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

