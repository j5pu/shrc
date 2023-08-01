# shellcheck shell=sh


# brew prefix
#
export HOMEBREW_PREFIX
# true if Darwin, false if Linux
#
export MACOS
# sudo path
#
SUDOC="$(command -v sudo 2>/dev/null)"; export SUDOC
# Darwin or Linux
#
UNAME="$(uname -s)"; export UNAME

if [ "${UNAME}" = "Darwin" ]; then
  HOMEBREW_PREFIX="/usr/local"
  MACOS=true
  unset PATH; eval "$(/usr/libexec/path_helper -s)"
else
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  MACOS=false

fi

