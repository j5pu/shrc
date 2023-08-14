#!/usr/bin/env bats

. bats.bash

@test "assert::helps is Docker daemon running?" {
  bats::success
}


@test "$(bats::basename) " {
  skip::if::not::command docker

  if docker version 2>&1 | grep -q "Is the docker daemon running"; then
    bats::failuree
  else
    bats::success
  fi
}
