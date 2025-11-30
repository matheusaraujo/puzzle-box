#!/bin/bash

available_challenges+=("ebc")
ignore_files+=(".ebc.session.cookie")

declare -A ebc_events=(
    [2024]=20
    [2025]=20
)

ebc_directory() {
    local day_str
    printf -v day_str "%02d" "$day"
    echo "everybody.codes/$year/day$day_str"
}

ebc_title() {
    echo "Everybody.Codes $year - Quest $day"
}