# shellcheck shell=bash

#######################################
# completions for color
# Globals:
#   COMPREPLY
#   cur
# Arguments:
#  None
# Returns:
#   <unknown> ...
#######################################
_color() { bash4_completions_one_command build demo; }

complete -F _color color
