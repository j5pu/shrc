# shellcheck shell=bash

#######################################
# docker_login
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
_docker_login() { bash4_completions_one_command $(docker-contexts) --all; }

complete -F _docker_login docker-login
