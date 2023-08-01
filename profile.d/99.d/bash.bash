# shellcheck shell=bash

[ "${PS1-}" ] || return 0

export PROMPT_COMMAND="history_prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
