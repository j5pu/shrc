# shellcheck shell=sh

# Git Command Line Tools ignores GIT_CONFIG_SYSTEM and GIT_CONFIG_GLOBAL
#
export GIT_CONFIG_SYSTEM="${SHRC_CONFIG}/git/gitconfig"
export GIT_TEMPLATE_DIR="${SHRC_CONFIG}/git/template"
