#!/bin/bash

available_challenges+=("ecd")

challenges_titles["ecd"]="Everybody Codes"
challenges_aliases["ecd"]="ecd"
challenges_aliases["everybody-codes"]="ecd"
challenges_aliases["everybody.codes"]="ecd"

challenge_event_regex["ecd"]="^(2024|2025|story1|story2)$"

ignore_files+=(".ecd.session.cookie")

declare -A ecd_events=(
    [2024]=20
    [2025]=20
    [story1]=3
    [story2]=3
)

ecd_directory() {
    local day_str
    printf -v day_str "%02d" "$((10#$day))"
    echo "everybody.codes/$event/quest$day_str"
}

ecd_problem_title() {
    local dir
    dir=$(ecd_directory)
    local title_file="$dir/data/title.txt"

    if [ -f "$title_file" ] && [ -s "$title_file" ]; then
        local title
        title=$(cat "$title_file")
        echo "Everybody.Codes $event - Quest $day: $title"
    else
        echo "Everybody.Codes $event - Quest $day"
    fi
}

ecd_input_file() {
    local dir=$(ecd_directory)
    local part=$1

    echo "$dir/data/input.$part.txt"
}