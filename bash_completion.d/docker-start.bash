# shellcheck shell=bash

#######################################
# docker-start
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
_docker_start() { bash4_completions_one_command $(docker-contexts) --all; }

complete -F _docker_start docker-start
