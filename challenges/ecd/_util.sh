#!/bin/bash

available_challenges+=("ecd")

challenges_titles["ecd"]="Everybody Codes"
challenges_aliases["ecd"]="ecd"
challenges_aliases["everybody-codes"]="ecd"
challenges_aliases["everybody.codes"]="ecd"

ignore_files+=(".ecd.session.cookie")

declare -A ecd_events=(
    [2024]=20
    [2025]=20
)

ecd_directory() {
    local day_str
    printf -v day_str "%02d" "$((10#$day))"
    echo "everybody.codes/$year/quest$day_str"
}

ecd_problem_title() {
    local dir
    dir=$(ecd_directory)
    local title_file="$dir/data/title.txt"

    if [ -f "$title_file" ] && [ -s "$title_file" ]; then
        local title
        title=$(cat "$title_file")
        echo "Everybody.Codes $year - Quest $day: $title"
    else
        echo "Everybody.Codes $year - Quest $day"
    fi
}

ecd_input_file() {
    local dir=$(ecd_directory)
    local part=$1

    echo "$dir/data/input.$part.txt"
}