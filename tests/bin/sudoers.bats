#!/usr/bin/env bats

setup() {
  load helpers/test_helper
}

@test "sudoers --version" { assert_version; }
