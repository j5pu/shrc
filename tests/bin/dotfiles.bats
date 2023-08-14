#!/usr/bin/env bats

. bats.bash

@test "assert::helps find dangling symlinks in directory (default: cwd)" {
  bats::success
}


@test "$(bats::basename)" {
  bats::success
}
