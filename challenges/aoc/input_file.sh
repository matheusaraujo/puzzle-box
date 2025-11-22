#!/bin/bash

aoc_ensure_input_file_exists() {
    input_file="advent-of-code/$year/day$day/data/input.txt"

    if [ ! -f "$input_file" ] || [ ! -s "$input_file" ]; then
        mkdir -p "$(dirname "$input_file")"
        curl -s -b session=$(cat .aoc.session.cookie) \
            https://adventofcode.com/$year/day/$(echo $day | sed 's/^0*//')/input -o "$input_file"

        if [ ! -s "$input_file" ]; then
            print_line "${RED}[Advent of Code] Failed to fetch input file or file is empty.${NC}"
            rm -rf $input_file
            return 1
        fi

        if grep -q "Puzzle inputs differ by user.  Please log in to get your puzzle input." "$input_file"; then
            print_line "${RED}[Advent of Code] You need to define a valid session cookie in the file '.aoc.session.cookie'.${NC}"
            rm -rf $input_file
            return 1
        fi
    fi
}
