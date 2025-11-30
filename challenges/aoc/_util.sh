#!/bin/bash

available_challenges+=("aoc")
ignore_files+=(".aoc.session.cookie")

aoc_directory() {
    echo "advent-of-code/$year/day$day"
}

aoc_title() {
    local dir
    dir=$(aoc_directory)
    local title_file="$dir/data/title.txt"

    if [ -f "$title_file" ] && [ -s "$title_file" ]; then
        local title
        title=$(cat "$title_file")
        echo "Advent of Code $year - Day $day: $title"
    else
        echo "Advent of Code $year - Day $day"
    fi
}
