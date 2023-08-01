# shellcheck shell=bash

#######################################
# Register the previous command easily
# https://github.com/knqyf263/pet#bash-prev-function
# Arguments:
#  None
#######################################
function prev() {
  local PREV
  PREV=$(history | tail -n2 | head -n1| sed 's/[0-9]*//' | xargs)
  sh -c "pet new $(printf %q "${PREV}")"
}

#######################################
# search snippets and output on the shell. Select snippets at the current line (like C-r)
# https://github.com/knqyf263/pet#select-snippets-at-the-current-line-like-c-r
# Globals:
#   BUFFER
#   READLINE_LINE
#   READLINE_POINT
# Arguments:
#  None
#######################################
function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
bind -x '"\C-x\C-r": pet-select'
