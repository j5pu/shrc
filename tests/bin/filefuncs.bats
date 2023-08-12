#!/usr/bin/env bats

. bats.bash

setup_file() { export HELPS_LINE="list functions in file/files, start at the beginning of the line, function()"; }

@test "$(bats::basename) " { bats::failure; assert_line "${HELPS_LINE}"; }

@test "assert::helps" { bats::success; }

@test "$(bats::basename) \"$(command -v bats.bash)\" " {
  bats::success
  refute_line _help
  assert_line bats::tmp
}
