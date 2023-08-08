#!/usr/bin/env bats

. bats.bash

setup_file() { export HELPS_LINE="is running on debian?"; }

@test "$(bats::basename) " {
  bats::run
  if ismacos; then
    assert_failure
  elif test -f /etc/os-release && hascmd apt-get; then
    assert_success
  else
    assert_failure
  fi
}

@test "assert::helps" { bats::success; }

@test "$(bats::basename) foo " {
  bats::failure
  assert_line "${HELPS_LINE}"
  assert_line "$(bats::basename): foo: invalid option/argument"
}
