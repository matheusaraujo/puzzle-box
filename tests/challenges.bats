#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/helper.bash"

setup() {
    pb_workdir
}

@test "aoc_directory builds a zero-padded day path" {
    event="2015"; puzzle="05"
    [ "$(aoc_directory)" = "advent-of-code/2015/day05" ]
}

@test "ecd_directory builds a zero-padded quest path" {
    event="2024"; puzzle="01"
    [ "$(ecd_directory)" = "everybody.codes/2024/quest01" ]
}

@test "aoc_problem_title includes the stored title when present" {
    event="2015"; puzzle="01"
    mkdir -p "advent-of-code/2015/day01/data"
    printf 'Not Quite Lisp' > "advent-of-code/2015/day01/data/title.txt"
    [ "$(aoc_problem_title)" = "Advent of Code 2015 - Day 01: Not Quite Lisp" ]
}

@test "aoc_problem_title degrades gracefully without a title file" {
    event="2015"; puzzle="02"
    [ "$(aoc_problem_title)" = "Advent of Code 2015 - Day 02" ]
}

@test "aoc_input_file points at data/input.txt" {
    event="2015"; puzzle="01"
    [ "$(aoc_input_file part1)" = "advent-of-code/2015/day01/data/input.txt" ]
}

@test "ecd_input_file is part-specific" {
    event="2024"; puzzle="01"
    [ "$(ecd_input_file part2)" = "everybody.codes/2024/quest01/data/input.part2.txt" ]
}

@test "aoc_validate_event_puzzle accepts an in-range day" {
    event="2015"; puzzle="05"
    run aoc_validate_event_puzzle
    [ "$status" -eq 0 ]
}

@test "aoc_validate_event_puzzle rejects an out-of-range day" {
    event="2015"; puzzle="40"
    run aoc_validate_event_puzzle
    [ "$status" -eq 1 ]
}

@test "ecd_validate_event_puzzle rejects an unknown event" {
    event="1999"; puzzle="01"
    run ecd_validate_event_puzzle
    [ "$status" -eq 1 ]
}

@test "ecd_validate_part enforces part1/part2/part3" {
    part="part4"
    run ecd_validate_part
    [ "$status" -eq 1 ]

    part="part3"
    run ecd_validate_part
    [ "$status" -eq 0 ]
}
