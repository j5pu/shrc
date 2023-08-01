# shellcheck shell=sh

#######################################
# show files added to $2 directory not in $1 directory (does not show empty files)
# Arguments:
#   1
#   2
#######################################
files_diff() {
  find "$1" "$2" -type f -name ".DS_Store" -delete;
  git diff --name-only --no-index "$1" "$2"; diff "$1" "$2";
}

#######################################
# show files added to $2 directory not in $1 directory (does not show empty files)
# Arguments:
#   1
#   2
#######################################
files_added() { git diff --diff-filter=A --name-only --no-index "$1" "$2"; }

#######################################
# show files deleted in $2 directory which where in $1 directory (does not show empty files)
# Arguments:
#   1
#   2
#######################################
files_deleted() { git diff --diff-filter=D --name-only --no-index "$1" "$2"; }

#######################################
# show files modified/changed in two directory (not deleted or added)
# Arguments:
#   1
#   2
#######################################
files_modified() { git diff --diff-filter=M --name-only --no-index "$1" "$2"; }
