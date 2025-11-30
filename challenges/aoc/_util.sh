#!/bin/bash

available_challenges+=("aoc")

challenges_aliases["aoc"]="aoc"
challenges_aliases["advent-of-code"]="aoc"
challenges_aliases["advent"]="aoc"

ignore_files+=(".aoc.session.cookie")

declare -A aoc_events=(
    [2015]=25
    [2016]=25
    [2017]=25
    [2018]=25
    [2019]=25
    [2020]=25
    [2021]=25
    [2022]=25
    [2023]=25
    [2024]=25
    [2025]=12
)

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
