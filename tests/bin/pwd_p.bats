#!/usr/bin/env bats

. bats.bash

@test "assert::helps physical pwd for path if it is a directory or for dirname if path exists (default: pwd)" {
  bats::success
}

@test "$(bats::basename) " {
  bats::success
  assert_output "$(pwd -P)"
}

@test "$(bats::basename) . " {
  bats::success
  assert_output "$(pwd -P)"
}

@test "$(bats::basename) ${BATS_TOP}/README.md " {
  bats::success
  assert_output "${BATS_TOP}"
}

@test "$(bats::basename) foo " {
  bats::failure
  assert_output "$(Error  "$(bats::basename):" "${BATS_ARRAY[1]} no such file/directory")"
}
