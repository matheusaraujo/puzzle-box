#!/bin/bash

aoc_validate_event_day() {
    day_num=$((10#$day))

    if [[ -n "${aoc_events[$event]}" ]]; then
        max_day=${aoc_events[$event]}
        if [ "$day_num" -ge 1 ] && [ "$day_num" -le "$max_day" ]; then
            return 0
        fi
    fi

    print_line "${RED}[Advent of Code] Invalid event ($event) or day ($day).${NC}"
    exit 1
}

aoc_validate_directory() {
    if [ ! -d "advent-of-code/$event/day$day" ]; then
        print_line "${RED}[Advent of Code] Directory does not exist for $event, day $day.${NC}"
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