#!/usr/bin/env bats

. bats.bash

bats_require_minimum_version 1.5.0

@test "assert::helps remove dangling symlinks in directory (default: cwd)" {
  bats::success
}


@test "$(bats::basename) ${BATS_FILE_TMPDIR}" {
  bats::array
  touch "${BATS_ARRAY[1]}"/a
  ln -s "${BATS_ARRAY[1]}"/a "${BATS_ARRAY[1]}"/b
  rm "${BATS_ARRAY[1]}"/a

  assert_link_exists "${BATS_ARRAY[1]}"/b

  bats::success
  assert_output  "$(Ok "${BATS_ARRAY[0]}" "${BATS_ARRAY[1]}/b: removed")"
  run ! assert_file_exists "${BATS_ARRAY[1]}"/b
  run ! assert_link_exists "${BATS_ARRAY[1]}"/b

}
