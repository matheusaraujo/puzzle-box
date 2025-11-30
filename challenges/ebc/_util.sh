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
    echo "everybody.codes/$year/day$day_str"
}

ebc_problem_title() {
    echo "Everybody.Codes $year - Quest $day"
}