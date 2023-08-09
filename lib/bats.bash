# shellcheck shell=bash

#. "$(dirname "${BASH_SOURCE[0]}")/utils.sh"
. "${SHRC_LIB?}/utils.sh"

# <html><h2>Bats Description Array</h2>
# <p><strong><code>$BATS_ARRAY</code></strong> created by bats::array() with $BATS_TEST_DESCRIPTION.</p>
# </html>
export BATS_ARRAY=()

# Docker Context for Container Tests (default: macOS or default for Linux)
#
export BATS_DOCKER_CONTEXT

# <html><h2>Array with Bats Libs Functions and Helper Functions Provided by bats/bats.sh</h2>
# <p><strong><code>$BATS_FUNCTIONS</code></strong> created by bats::array() with $BATS_TEST_DESCRIPTION.</p>
# </html>
export BATS_FUNCTIONS

# Bats Libs Repositories
#
export BATS_LIBS="bats-assert bats-file bats-support"

# Run only local tests when set to 1, otherwise run container tests (Default: 0 when isaction is true).
#
: "${BATS_LOCAL=0}"; export BATS_LOCAL

# <html><h2>Saved $INFOPATH on First Suite Test Start after bats::env</h2>
# <p><strong><code>$BATS_INFOPATH</code></strong></p>
# </html>
export BATS_SAVED_INFOPATH

# <html><h2>Saved $MANPATH on First Suite Test Start after bats::env</h2>
# <p><strong><code>$BATS_MANPATH</code></strong></p>
# </html>
export BATS_SAVED_MANPATH

# <html><h2>Saved $PATH on First Suite Test Start after bats::env</h2>
# <p><strong><code>$BATS_SAVED_PATH</code></strong>bats-core adds bats-core libexec</p>
# </html>
export BATS_SAVED_PATH

# Verbose show Docker Command.
#
: "${BATS_SHOW_DOCKER_COMMAND=0}"; export BATS_SHOW_DOCKER_COMMAND

# <html><h2>Start $INFOPATH on First Suite Test Start</h2>
# <p><strong><code>$BATS_INFOPATH</code></strong></p>
# </html>
export BATS_START_INFOPATH="${INFOPATH}"

# <html><h2>Start $MANPATH on First Suite Test Start</h2>
# <p><strong><code>$BATS_MANPATH</code></strong></p>
# </html>
export BATS_START_MANPATH="${MANPATH}"

# <html><h2>Start $PATH on First Suite Test Start</h2>
# <p><strong><code>$BATS_START_PATH</code></strong></p>
# </html>
export BATS_START_PATH="${PATH}"

# Output directory to write gathered tests results
#
export BATS_OUTPUT="${HOME}/.local/log/bats"; mkdir -p "${BATS_OUTPUT}"

# Bats Core and Bats Libs Repositories
#
export BATS_REPOS="bats-core ${BATS_LIBS}"

# <html><h2>Bats Remote and Local Repository Array</h2>
# <p><strong><code>$BATS_REMOTE</code></strong> created by bats::remote(), [0] repo, [1] remote.</p>
# </html>
export BATS_REMOTE=()

# Installation Directory for bats-core and bats libs
#
export BATS_SHARE="${HOME}/.local/share"; mkdir -p "${BATS_SHARE}"

# <html><h2>Git Top Path</h2>
# <p><strong><code>$BATS_TOP</code></strong> contains the git top directory using $PWD.</p>
# </html>
BATS_TOP="$(git rev-parse --show-toplevel 2>/dev/null || true)"; export BATS_TOP

# Bats Core executable path
#
export BATS_EXECUTABLE="${BATS_SHARE}/bats-core/bin/bats"

# <html><h2>Git Top Basename</h2>
# <p><strong><code>$BATS_TOP_NAME</code></strong> basename of git top directory when sourced from a git dir.</p>
# </html>
export BATS_BASENAME="${BATS_TOP##*/}"

export INFOPATH

export MANPATH

#######################################
# assert -h, --help, help with $HELPS_LINE
# Globals:
#   HELPS_LINE
# Arguments:
#   1   HELPS_LINE
# Examples:
# @test "assert::helps starts Docker daemon if not running" {
#  ${BATS_TEST_DESCRIPTION}
#}
#
# @test "assert::helps starts Docker daemon if not running" {
#  bats::success
#}
# setup_file() { HELPS_LINE="foo" }
#@test "assert::helps" {
#  bats::success
#}
#######################################
assert::helps() {
  local helps_line option run
  run="$(bats::basename)"
  helps_line="${HELPS_LINE:-$@}"
  assert [ -n "${helps_line}" ]
  for option in -h --help help; do
    run "${run}" "${option}"
    assert_success
    assert_line "${helps_line}"
  done
}

#######################################
# creates $BATS_ARRAY array from $BATS_TEST_DESCRIPTION or argument
# Globals:
#   BATS_ARRAY
#   BATS_TEST_DESCRIPTION
#######################################
# shellcheck disable=SC2086
bats::array() { mapfile -t BATS_ARRAY < <(xargs printf '%s\n' <<<${BATS_TEST_DESCRIPTION}); }

#######################################
# Bats Test File Basename Without Suffix
# Globals:
#   BATS_ARRAY
#   BATS_TEST_DESCRIPTION
#######################################
bats::basename() { basename "${BATS_TEST_FILENAME-}" .bats; }

#######################################
# Changes to top repository path \$BATS_TOP and top path found, otherwise changes to the \$BATS_TESTS
# Globals:
#   BATS_ROOT
#   BATS_TESTS
#   BATS_TOP
#######################################
bats::cd() { cd "${BATS_TOP:-${BATS_TESTS:-.}}" || return; }

#######################################
# Restores $PATH to $BATS_SAVED_PATH and sources .envrc.
# Globals:
#   PATH
# Arguments:
#  None
#######################################
bats::env() {
  bats::cd

  PATH="${BATS_START_PATH}"
  MANPATH="${BATS_START_MANPATH}"
  INFOPATH="${BATS_START_INFOPATH}"
  path_add_exist_all "${BATS_TOP}"
  ! test -f "${BATS_TOP}/.env" || source "${BATS_TOP}/.env"
  BATS_SAVED_PATH="${PATH}"
  BATS_SAVED_MANPATH="${MANPATH}"
  BATS_SAVED_INFOPATH="${INFOPATH}"

  # TODO: envfile
  #  . "$(dirname "${BASH_SOURCE[0]}")/envfile.sh"
  #  envfile
}

#######################################
# run description array and asserts if failure
# Globals:
#   BATS_ARRAY
# Arguments:
#  None
# Caution:
#  Do not se it with single quotes ('echo "1 2" 3 4'), use double quotes ("echo '1 2' 3 4")
#######################################
bats::failure() {
  bats::run
  assert_failure
}

#######################################
# create a remote, a local temporary directory and change to local repository directory (no commits added)
# Globals:
#   BATS_REMOTE
# Arguments:
#  1  directory name (default: random name)
#######################################
bats::remote() {
  local pwd_p="$(pwd_p "$(bats::tmp "${1:-$RANDOM}")")"
  local pwd_p_git="$(pwd_p "$(bats::tmp "${1:-$RANDOM}.git")")"
  BATS_REMOTE=("${pwd_p}" "${pwd_p_git}"); export BATS_REMOTE
  git -C "${BATS_REMOTE[1]}" init --bare --quiet
  cd "${BATS_REMOTE[0]}" || return
  git init --quiet
  git branch -M main
  git remote add origin "${BATS_REMOTE[1]}"
  git config branch.main.remote origin
  git config branch.main.merge refs/heads/main
  git config user.name "${BATS_BASENAME}"
  git config user.email "${BATS_BASENAME}@example.com"
}

#######################################
# run description array
# Globals:
#   BATS_ARRAY
# Arguments:
#  None
# Caution:
#  Do not se it with single quotes ('echo "1 2" 3 4'), use double quotes ("echo '1 2' 3 4")
#######################################
bats::run() {
  bats::array
  run "${BATS_ARRAY[@]}"
}

#######################################
# run description array and asserts if success
# Globals:
#   BATS_ARRAY
# Arguments:
#  None
# Caution:
#  Do not se it with single quotes ('echo "1 2" 3 4'), use double quotes ("echo '1 2' 3 4")
#######################################
bats::success() {
  bats::run
  assert_success
}

#######################################
# create a temporary directory in $BATS_FILE_TMPDIR if arg is provided
# Globals:
#   BATS_FILE_TMPDIR
# Arguments:
#  1  directory name (default: returns $BATS_FILE_TMPDIR)
# Outputs:
#  new temporary directory or $BATS_FILE_TMPDIR
#######################################
bats::tmp() {
  local GENERATED="${BATS_FILE_TMPDIR}${1:+/$1}"
  [ ! "${1-}" ] || mkdir -p "${GENERATED}"
  echo "${GENERATED}"
}

#######################################
# skip if GitHub action
# Arguments:
#  None
#######################################
skip::if::action() {
  ! isaction || skip "GitHub action"
}

#######################################
# skip test if var is not defined
# Globals:
#   var
# Arguments:
#  None
#######################################
skip::if::not::command() {
  has "$1" || skip "${1}: not installed"
}

#######################################
# skip test if var is not defined
# Globals:
#   var
# Arguments:
#  None
#######################################
skip::if::not::var() {
  [ "${!1-}" ] || skip "Missing: ${1}"
}

#######################################
# clone bats-core and bats libs
# Globals:
#   BATS_EXECUTABLE
#   BATS_REPOS
#   BATS_SHARE
# Arguments:
#  None
# Returns:
#   0 ...
#######################################
_bats_clone() {
  ! test -x "${BATS_EXECUTABLE}" || return 0
  local i
  for i in ${BATS_REPOS}; do
    git -C "${BATS_SHARE}" clone --quiet --depth 1 "https://github.com/bats-core/${i}" || return
  done
}

#######################################
# bats libs
# Globals:
#   BASH_SOURCE
#   __brew_lib
#   i
# Arguments:
#  None
# Returns:
#   1 ...
#######################################
_bats_libs() {
  local file i
  for i in ${BATS_LIBS}; do
    file="${BATS_SHARE}/${i}/load.bash"
    . "${file}" || RETURN="return" _die "${file}: sourcing error"
  done
}

#######################################
# pull bats-core and bats libs
# Globals:
#   BATS_REPOS
#   BATS_SHARE
# Arguments:
#  None
# Returns:
#   0 ...
#######################################
_bats_pull() {
  local i
  for i in ${BATS_REPOS}; do
    git -C "${BATS_SHARE}/${i}" pull --quiet
  done
}

#######################################
# die with return or exit
# Globals:
#   RETURN
# Arguments:
#   None
#######################################
_die() {
  local rc=$?
  printf >&2 '%b\n' "\033[1;31m✘\033[0m ${BASH_SOURCE[0]##*/}: $*"
  "${RETURN:-exit}" $rc
}

#######################################
# start docker
# Globals:
#   BATS_DOCKER_CONTEXT
#   BATS_LOCAL
# Arguments:
#   0
# Returns:
#   1 ...
#######################################
_docker() {
  ! [[ "${1-}" =~ -h|--help|--man|--man7|-v|--version|bashpro|commands|help|functions|list  ]] || return 0

  if isaction || ! has docker; then
    BATS_LOCAL=1
  elif test "${BATS_LOCAL}" -eq 0; then
    if [ ! "${BATS_DOCKER_CONTEXT-}" ]; then
      if ismacos; then
        BATS_DOCKER_CONTEXT="default"
      else
        BATS_DOCKER_CONTEXT="default"
      fi
    fi

    if [ "$(docker context show)" != "${BATS_DOCKER_CONTEXT}" ]; then
      docker context use "${BATS_DOCKER_CONTEXT}" >/dev/null || \
        { >&2 echo "Docker: Change context to: ${BATS_DOCKER_CONTEXT}: failed"; return 1; }
      ! fd3 || >&3 echo "${0##*/}: Docker: Changed context to: ${BATS_DOCKER_CONTEXT}"
    fi

    if ! docker-running; then
      ! fd3 || >&3 echo "${0##*/}: Docker: Starting"
      docker-start
      ! fd3 || >&3 echo "${0##*/}: Docker: Started"

      if ! docker-running; then
        ! fd3 || >&3 echo "${0##*/}: Error: Starting Docker"
        >&2 echo "${0##*/}: Error: Starting Docker"; return 1 2>/dev/null || exit
      fi
    fi
  fi
}

#######################################
# export bats functions
# Globals:
#   ${BATS_FUNCTIONS[@]}
#   BASH_SOURCE
#   BATS_FUNCTIONS
#   BATS_SHARE
# Arguments:
#  None
#######################################
_functions() {
  mapfile -t BATS_FUNCTIONS < <(
    filefuncs "${BATS_SHARE}"/bats-*/src/*.bash \
      && filefuncs "${BASH_SOURCE[0]}"
  )
  export_funcs_path "${BASH_SOURCE[0]}"
  # bashsupport disable=BP2001
  export -f "${BATS_FUNCTIONS[@]}" && funcexported assert && funcexported bats::env
}

#######################################
# show help and exit
# Arguments:
#   None
#######################################
_help() {
  local rc=$? script="${0##*/}"
  local sh="${script/.sh/}.sh"
  [ ! "${1-}" ] || {
    echo -e "${0##*/}: ${1}: ${2}\n"
    rc=1
  }
  cat <<EOF
usage: ${script} [<tests>] [<options>]
   or: ${sh} [<tests>] [<options>]
   or: ${script} -h|-help|commands|help|functions|verbose
   or: ${sh} -h|-help|commands|help|functions|verbose
   or: . ${script}
   or: . ${sh}

bats testing wrapper and helper functions when "${script}" or "${sh}" sourced

<tests> is the path to a Bats test file, or the path to a directory containing Bats
test files (ending with ".bats"). If no <tests> run for: first directory found with ".bats"
files in working directory, or either 'tests', 'test' or '__tests__' under top repository path.

Changes to top repository path \$BATS_TOP when running tests and top path found, otherwise changes
to the \$BATS_TEST_DIR

Adds top repository path: sbin, bin and libexec to \$PATH and sources .env

Commands:
  -h, --help, help          display this help and exit
  bashpro                   patches bashpro plugin (remove in run configuration to add to PATH)
  commands                  display ${script}' commands
  functions                 display functions available when ${script} is sourced
  list                      display tests found relative to current working directory

Options:
  --dry-run                 show command that would be executed and globals
  --man                     show bats(1) man page
  --man7                    show bats(7) man page
  --one                     run only one job in parallel instead of \$BATS_NUMBER_OF_PARALLEL_JOBS
  --verbose                 run bats tests showing all outputs, with trace and not cleaning the tempdir

Bats options:
$(awk '/--count/,0' < <("${BATS_EXECUTABLE}" --help))

Globals:
   BATS_COMMAND             Command Executed.
   BATS_GATHER              Gather the output of failing *and* passing tests as
                            files in directory [--gather-test-outputs-in].
   BATS_OUTPUT              Directory to write report files [-o|--output].
   BATS_TEST_DIR            Path to the test directory, passed as argument or found by '${script}'.
   BATS_TESTS               Array of tests found.

$("${BATS_EXECUTABLE}" --version)
EOF
  exit $rc
}

#######################################
# ok message
# Arguments:
#   1  message
#######################################
_ok() { printf >&2 '%b\n' "\033[1;32m✔\033[0m ${BASH_SOURCE[0]##*/}: $*"; }

#######################################
# unsets functions
# Arguments:
#  None
#######################################
_unsets() {
  unset -f _bats_clone _bats_libs _bats_pull _die _directory _file _help _main _unsets
}

#######################################
# parse arguments when is executed and run bats  (private used by bats.bash)
# Globals:
#   OPTS_BACK
# Arguments:
#   None
#######################################
_main() {
  local sourced=false
  [ "${BASH_SOURCE##*/}" = "${0##*/}" ] || sourced=true

  ! $sourced || { $sourced && ! funcexported assert 2>/dev/null; } || {
    _unsets
    return
  }

  _bats_clone || return
  $sourced || _bats_pull || return
  _bats_libs || return
  _functions || return

  bats::env || return
  _docker "$@" || return

  ! $sourced || {
    _unsets
    return
  }
}

_main "$@"
