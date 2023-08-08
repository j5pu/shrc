#!/usr/bin/env bats

. bats.bash

# executed before each test
setup_file() {
    TMPDIR="$(mktemp -d)"; export TMPDIR
    export SRC_A="${TMPDIR}/source_file"
    touch ${SRC_A}

    export SRC_B="${TMPDIR}/source_dir"
    mkdir -p ${SRC_B}

    export SRC_C="${TMPDIR}/1/2/3"
    mkdir -p ${SRC_C}
    SRC_C="${TMPDIR}/1/2/3/source_file"
    touch ${SRC_C}

    export SRC_D="${TMPDIR}/1/2/source_dir"
    mkdir -p ${SRC_D}

    export SRC_E="${TMPDIR}/1/2/source_file"
    touch ${SRC_E}

    export SRC_F="${TMPDIR}/1/2/3/source_dir"
    mkdir -p ${SRC_F}

    export SRC_G="${TMPDIR}/1/ls"

    export SRC_H="${TMPDIR}/1/sbin"
}

teardown_file() {
  # executed after each test
  rm -rf "${TMPDIR?}"/*
}

@test "assert::helps creates relative symlinks from destination directory" {
  bats::success
}

@test "$(bats::basename) ${SRC_A} ${BATS_TMPDIR}/A/B/C/target_file" {
  bats::success
  echo "${BATS_ARRAY[2]}" >&3
  realpath "${BATS_ARRAY[2]}" >&3
  assert_output "✔ ln: ../../../source_file => target_file"
#
#  bats::failure
#  assert output <<EOF
#ln: target_file: File exists
#✘ relative: symlink can not be created
#EOF
#
#   run $(bats::basename) -f "${BATS_ARRAY[1]}" "${BATS_ARRAY[2]}"
#   assert_success
}

@test "$(bats::basename) ${SRC_B} ${BATS_TMPDIR}/D/E/target_file" {
  bats::success
}

@test "$(bats::basename) ${SRC_C} ${BATS_TMPDIR}/E/target_file" {
  bats::success
}

@test "$(bats::basename) ${SRC_D} ${BATS_TMPDIR}/F/target_dir" {
  bats::success
}

@test "$(bats::basename) ${SRC_E} ${BATS_TMPDIR}/G/E/target_file" {
  bats::success
}

@test "$(bats::basename) ${SRC_F} ${BATS_TMPDIR}/H/I/J/target_dir" {
  bats::success
}

@test "$(bats::basename) /bin/ls ${SRC_G}" {
  bats::success
}

@test "$(bats::basename) /usr/bin ${SRC_H}" {
  bats::success
}
