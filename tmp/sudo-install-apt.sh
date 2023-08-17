#
# sudo path if sudo is installed or installs sudo for apt.

if ! command -v sudo; then
  if [ -d /etc/apt ]; then
    apt -qq update -y && apt -qq install -y sudo && command -v sudo
  fi
fi
