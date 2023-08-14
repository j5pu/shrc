# shellcheck shell=bash

#######################################
# docker-contexts
# Arguments:
#   None
#######################################
# shellcheck disable=SC2046
_docker_contexts() { completions_one_command; }

complete -F _docker_contexts docker-contexts
