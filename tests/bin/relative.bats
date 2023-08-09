#!/usr/bin/env bats

. bats.bash

# executed before each test
setup_file() {
    TMPDIR="$(mktemp -d)"; export TMPDIR
    export SRC_A="${TMPDIR}/source_file"
    touch "${SRC_A}"

    export SRC_B="${TMPDIR}/source_dir"
    mkdir -p "${SRC_B}"

    export SRC_C="${TMPDIR}/1/2/3"
    mkdir -p "${SRC_C}"
    SRC_C="${TMPDIR}/1/2/3/source_file"
    touch "${SRC_C}"

    export SRC_D="${TMPDIR}/1/2/source_dir"
    mkdir -p "${SRC_D}"

    export SRC_E="${TMPDIR}/G/E/source_file"
    mkdir -p "${TMPDIR}/G/E"
    touch "${SRC_E}"

    export SRC_F="${TMPDIR}/H/I/J/source_dir"
    mkdir -p "${SRC_F}"

    export SRC_G="${TMPDIR}/1/ls"

    export SRC_H="${TMPDIR}/1/sbin"
}

teardown_file() {
  # executed after each test
  rm -rf "${TMPDIR:?}"/*
}

equal() {
  assert_equal "$(realpath "${BATS_ARRAY[1]}")" "$(realpath "${BATS_ARRAY[2]}")"
}

@test "assert::helps creates relative symlinks from destination directory" {
  bats::success
}

@test "$(bats::basename) ${SRC_A} ${TMPDIR}/A/B/C/target_file" {
  bats::success
  equal
  assert_output "$(FromTo ln "../../../source_file" "target_file")"

  bats::failure
  assert_output <<EOF
ln: target_file: File exists
$(Error "relative:" "symlink can not be created")
EOF

  run $(bats::basename) -f "${BATS_ARRAY[1]}" "${BATS_ARRAY[2]}"
  assert_success
  equal
  assert_output <<EOF
$(Warning relative: "${BATS_ARRAY[2]} removed")
$(FromTo ln "../../../source_file" "target_file")
EOF
}

@test "$(bats::basename) ${SRC_B} ${TMPDIR}/D/E/target_dir" {
  bats::success
  equal
  assert_output "$(FromTo ln "../../source_dir" "target_dir")"
}

@test "$(bats::basename) ${SRC_C} ${TMPDIR}/E/target_file" {
  bats::success
  equal
  assert_output "$(FromTo ln "../1/2/3/source_file" "target_file")"
}

@test "$(bats::basename) ${SRC_D} ${TMPDIR}/F/target_dir" {
  bats::success
  equal
  assert_output "$(FromTo ln "../1/2/source_dir" "target_dir")"
}

@test "$(bats::basename) ${SRC_E} ${TMPDIR}/G/E/target_file" {
  bats::success
  equal
  assert_output "$(FromTo ln "./source_file" "target_file")"
}

@test "$(bats::basename) ${SRC_F} ${TMPDIR}/H/I/J/target_dir" {
  bats::success
  equal
  assert_output "$(FromTo ln "./source_dir" "target_dir")"
}

@test "$(bats::basename) /bin/ls ${SRC_G}" {
  bats::success
  assert_output "$(FromTo ln "/bin/ls" "${SRC_G}")"
}

@test "$(bats::basename) /usr/bin ${SRC_H}" {
  bats::success
  assert_output "$(FromTo ln "/usr/bin" "${SRC_H}")"
}
