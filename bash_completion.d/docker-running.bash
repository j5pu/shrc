# shellcheck shell=bash

#######################################
# docker-running
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
_docker_running() { bash4_completions_one_command $(docker-contexts) --all; }

complete -F _docker_running docker-running
