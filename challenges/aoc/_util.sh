#!/bin/bash

available_challenges+=("aoc")

challenges_titles["aoc"]="Advent of Code"
challenges_aliases["aoc"]="aoc"
challenges_aliases["advent-of-code"]="aoc"
challenges_aliases["advent"]="aoc"

challenge_event_regex["aoc"]="^(2015|2016|2017|2018|2019|2020|2021|2022|2023|2024|2025)$"

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
    local day_str
    printf -v day_str "%02d" "$((10#$day))"
    echo "advent-of-code/$event/day$day_str"
}

aoc_problem_title() {
    local dir
    dir=$(aoc_directory)
    local title_file="$dir/data/title.txt"

    if [ -f "$title_file" ] && [ -s "$title_file" ]; then
        local title
        title=$(cat "$title_file")
        echo "Advent of Code $event - Day $day: $title"
    else
        echo "Advent of Code $event - Day $day"
    fi
}

aoc_input_file() {
    local dir=$(aoc_directory)
    # local part=$1

    echo "$dir/data/input.txt"
}
