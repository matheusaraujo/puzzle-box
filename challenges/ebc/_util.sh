#!/bin/bash

available_challenges+=("ebc")

challenges_titles["ebc"]="Everybody Codes"
challenges_aliases["ebc"]="ebc"
challenges_aliases["everybody-codes"]="ebc"
challenges_aliases["everybody.codes"]="ebc"

ignore_files+=(".ebc.session.cookie")

declare -A ebc_events=(
    [2024]=20
    [2025]=20
)

ebc_directory() {
    local day_str
    printf -v day_str "%02d" "$((10#$day))"
    echo "everybody.codes/$year/quest$day_str"
}

ebc_problem_title() {
    local dir
    dir=$(ebc_directory)
    local title_file="$dir/data/title.txt"

    if [ -f "$title_file" ] && [ -s "$title_file" ]; then
        local title
        title=$(cat "$title_file")
        echo "Everybody.Codes $year - Quest $day: $title"
    else
        echo "Everybody.Codes $year - Quest $day"
    fi
}

ebc_input_file() {
    local dir=$(ebc_directory)
    local part=$1

    echo "$dir/data/input.$part.txt"
}