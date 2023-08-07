# shellcheck shell=sh

alias pending="brctl status | grep -c Under; brctl dump --upgrade | egrep '    \+ downloads:|    \+ uploads:|    \+ apply:|      up:'"
