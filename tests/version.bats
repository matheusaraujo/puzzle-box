#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/helper.bash"

setup() {
    pb_workdir
}

@test "pb_get_version reads the VERSION file by default" {
    unset PUZZLE_BOX_VERSION
    [ "$(pb_get_version)" = "$(cat "$ROOT/VERSION")" ]
}

@test "pb_get_version prefers the PUZZLE_BOX_VERSION override" {
    PUZZLE_BOX_VERSION="9.9.9" run pb_get_version
    [ "$output" = "9.9.9" ]
}

@test "pb_get_version falls back to dev when nothing is set" {
    run env -u PUZZLE_BOX_VERSION bash -c 'ROOT=/nonexistent; source "'"$ROOT"'/core/version.sh"; pb_get_version'
    [ "$output" = "dev" ]
}
