#!/usr/bin/env bats

.  bats.bash

vars() {
  skip::if::not::command docker

  for var in DOCKER_HUB_TOKEN GH_TOKEN GIT; do
    skip::if::not::var "${var}"
  done

  docker-running || >&3 echo "Docker daemon starting"
}

teardown_file() {
  if has docker && [ "${CONTEXT}" != "${LAST_CONTEXT}" ]; then
    docker context use "${CONTEXT}"
  fi
}


@test "login to Docker registry and GitHub docker registry" {
  bats::success
}


@test "$(bats::basename) " {
  vars

  bats::success
}

@test "$(bats::basename) foo " {
  vars

  bats::failure
  assert_output --regexp "context \"foo\": context not found"
}

@test "assert::helps login to Docker registry and GitHub docker registry" {
  bats::success
}
