# shellcheck shell=sh

# "Usually, ack only checks your ~/.ackrc file for it’s default switches.
# Per directory ack settings can be enabled by adding this in your environment, maybe via .bash_profile: "
export ACKRC="${SHRC_CONFIG}/ack/.ackrc"

# CLOUDSDK_CONFIG.                             Google Cloud config directory.
#
#export CLOUDSDK_CONFIG="${ETC}/gcloud"

export DIRENV_CONFIG="${SHRC_CONFIG}/direnv"

# DOCKER_CONFIG         The location of your client configuration files.
#
# export DOCKER_CONFIG="${SHRC_CONFIG}/docker"

# GH_CONFIG_DIR:                               Directory where gh will store configuration files.
#                                              Default: '$XDG_CONFIG_HOME/gh' or "$HOME/.config/gh".
#export GH_CONFIG_DIR="${SHRC_CONFIG}/gh"

# Git Command Line Tools ignores GIT_CONFIG_SYSTEM and GIT_CONFIG_GLOBAL
#
export GIT_CONFIG_SYSTEM="${SHRC_CONFIG}/git/gitconfig"
export GIT_TEMPLATE_DIR="${SHRC_CONFIG}/git/template"

# https://pip.pypa.io/en/stable/topics/configuration/#
#
export PIP_CONFIG_FILE="${SHRC_CONFIG}/pip/pip.conf"

export INPUTRC="${SHRC_CONFIG}/readline/inputrc"

export STARSHIP_CONFIG="${SHRC_CONFIG}/starship/config.toml"
