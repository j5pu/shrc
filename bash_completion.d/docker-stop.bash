# shellcheck shell=bash

#######################################
# docker-stop
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
_docker_stop() { completions_one_command $(docker-contexts) --all; }

complete -F _docker_stop docker-stop
