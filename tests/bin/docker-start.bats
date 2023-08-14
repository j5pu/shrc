#!/usr/bin/env bats

. bats.bash

@test "assert::helps starts Docker daemon if not running" {
  bats::success
}


@test "$(bats::basename) " {
  skip::if::not::command docker

  if ! docker-running; then
    >&3 echo "Docker daemon starting"
    bats::success
  fi

  run docker-running
  assert_success
}
