# shellcheck shell=sh

export PYTHON_DEFAULT_VERSION="3.11"
! cmd ipythondir || IPYTHONDIR="$(ipythondir)"; export IPYTHONDIR
! cmd pythonstartup || PYTHONSTARTUP="$(pythonstartup)"; export PYTHONSTARTUP