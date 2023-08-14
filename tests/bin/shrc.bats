#!/usr/bin/env bats

. bats.bash

@test "assert::helps shrc command to install bin, man and bash_completion.d, from the top of a repository into to shrc external directory: ${SHRC_EXTERNAL}" {
  bats::success
}

@test "$(bats::basename)" {
  bats::failure
  assert_output "$( Error "$(bats::basename):"  "${BATS_TOP} is not a shrc project";)"
}
