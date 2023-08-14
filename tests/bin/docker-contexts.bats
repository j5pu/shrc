#!/usr/bin/env bats

. bats.bash

@test "assert::helps list docker contexts" {
  bats::success
}


@test "$(bats::basename) " {
  skip::if::not::command docker
  bats::success
  assert_line "default"
}
