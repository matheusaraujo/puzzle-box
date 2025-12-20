#!/bin/bash

aoc_validate_event_puzzle() {
    puzzle_num=$((10#$puzzle))

    if [[ -n "${aoc_events[$event]}" ]]; then
        last_puzzle=${aoc_events[$event]}
        if [ "$puzzle_num" -ge 1 ] && [ "$puzzle_num" -le "$last_puzzle" ]; then
            return 0
        fi
    fi

    print_line "${RED}[Advent of Code] Invalid event ($event) or day ($puzzle).${NC}"
    exit 1
}

aoc_validate_directory() {
    if [ ! -d "advent-of-code/$event/day$puzzle" ]; then
        print_line "${RED}[Advent of Code] Directory does not exist for $event, day $puzzle.${NC}"
        exit 1
    fi
}

aoc_validate_part() {
    if [ -z "$part" ]; then
        print_line "${RED}[ERROR] Part must be defined (part1 or part2).${NC}"
        exit 1
    elif [[ "$part" != "part1" && "$part" != "part2" ]]; then
        print_line "${RED}[ERROR] Part must be either part1 or part2.${NC}"
        exit 1
    fi
}