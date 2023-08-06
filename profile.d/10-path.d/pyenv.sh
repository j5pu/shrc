# shellcheck shell=sh

! cmd pyenv || { eval "$(pyenv init --path)"; eval "$(pyenv init -)"; }
