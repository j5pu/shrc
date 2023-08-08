#!/usr/bin/env bats

. bats.bash

f() { :; }

@test "assert::helps checks if function is exported " {
  bats::success
}

@test "$(bats::basename) bats::run " { bats::success; }

@test "$(bats::basename) f " { bats::failure; }
