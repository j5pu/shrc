#!/usr/bin/env bats

. bats.bash

@test "assert::helps list users who can log in into the system" {
  bats::success
}

@test "$(bats::basename)" {
  bats::success
  assert_line "$(whoami)"
  assert_line "root"
}
