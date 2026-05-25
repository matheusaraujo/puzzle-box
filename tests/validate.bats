#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/helper.bash"

setup() {
    pb_workdir
}

@test "validate_challenge fails when unset" {
    challenge=""
    run validate_challenge
    [ "$status" -eq 1 ]
}

@test "validate_challenge fails for an unknown challenge" {
    challenge="nope"
    run validate_challenge
    [ "$status" -eq 1 ]
    [[ "$output" == *"must be one of"* ]]
}

@test "validate_challenge passes for a registered challenge" {
    challenge="aoc"
    run validate_challenge
    [ "$status" -eq 0 ]
}

@test "validate_lang fails when unset" {
    lang=""
    run validate_lang
    [ "$status" -eq 1 ]
}

@test "validate_lang fails for an unknown language" {
    lang="cobol"
    run validate_lang
    [ "$status" -eq 1 ]
}

@test "validate_lang passes for a registered language" {
    lang="python"
    run validate_lang
    [ "$status" -eq 0 ]
}

@test "validate_event and validate_puzzle require a value" {
    event=""
    run validate_event
    [ "$status" -eq 1 ]

    puzzle=""
    run validate_puzzle
    [ "$status" -eq 1 ]
}
