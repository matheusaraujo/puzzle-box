#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/helper.bash"

setup() {
    pb_workdir
}

@test "resolves challenge aliases to canonical names" {
    parse_args aoc
    [ "$challenge" = "aoc" ]

    challenge=""
    parse_args advent-of-code
    [ "$challenge" = "aoc" ]

    challenge=""
    parse_args everybody.codes
    [ "$challenge" = "ecd" ]
}

@test "matches event only against the active challenge regex" {
    parse_args aoc 2015
    [ "$event" = "2015" ]
}

@test "accepts story events for ecd" {
    parse_args ecd story3
    [ "$event" = "story3" ]
}

@test "zero-pads the puzzle number" {
    parse_args aoc 2015 5
    [ "$puzzle" = "05" ]

    puzzle=""
    parse_args aoc 2015 25
    [ "$puzzle" = "25" ]
}

@test "resolves language aliases" {
    parse_args py
    [ "$lang" = "python" ]

    lang=""
    parse_args js
    [ "$lang" = "javascript" ]
}

@test "parses part and flags" {
    parse_args part2 --watch --all --challenge --event
    [ "$part" = "part2" ]
    [ "$watch_mode" = "true" ]
    [ "$exec_all" = "true" ]
    [ "$exec_challenge" = "true" ]
    [ "$exec_event" = "true" ]
}

@test "accepts -w as a watch alias" {
    parse_args -w
    [ "$watch_mode" = "true" ]
}

@test "rejects unknown options with a non-zero exit" {
    run parse_args --does-not-exist
    [ "$status" -eq 1 ]
    [[ "$output" == *"Unknown option"* ]]
}

@test "update_pb_env writes then updates keys idempotently" {
    update_pb_env challenge aoc
    update_pb_env event 2015
    update_pb_env event 2016
    [ "$(grep -c '^event=' .pb-env)" -eq 1 ]
    grep -qx 'event=2016' .pb-env
    grep -qx 'challenge=aoc' .pb-env
}

@test "load_env_from_file restores saved context" {
    printf 'challenge=ecd\nevent=2024\npuzzle=07\n' > .pb-env
    load_env_from_file
    [ "$challenge" = "ecd" ]
    [ "$event" = "2024" ]
    [ "$puzzle" = "07" ]
}

@test "load_env_from_file does not execute embedded commands" {
    cat > .pb-env <<'EOF'
challenge=aoc
malicious=$(touch HACKED)
EOF
    load_env_from_file
    [ ! -f HACKED ]
    [ "$challenge" = "aoc" ]
}
