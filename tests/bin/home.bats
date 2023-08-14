#!/usr/bin/env bats

. bats.bash

@test "assert::helps show user's home, default $HOME" {
  bats::success
}

@test "$(bats::basename)" {
  bats::success
}


@test "$(bats::basename) $(whoami)" {
  bats::success "${HOME}"
}

@test "$(bats::basename) root" {
  bats::success
  if $MACOS; then
    assert_output "/var/root"
  else
    assert_output "/root"
  fi
}
