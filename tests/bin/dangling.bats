#!/usr/bin/env bats

. bats.bash

@test "assert::helps find dangling symlinks in directory (default: cwd)" {
  bats::success
}


@test "$(bats::basename) ${BATS_FILE_TMPDIR}" {
  bats::array
  touch "${BATS_ARRAY[1]}"/a
  ln -s "${BATS_ARRAY[1]}"/a "${BATS_ARRAY[1]}"/b
  rm "${BATS_ARRAY[1]}"/a


  bats::success
  assert_output "${BATS_ARRAY[1]}"/b
}
