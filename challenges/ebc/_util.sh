#!/bin/bash

available_challenges+=("ebc")
ignore_files+=(".ebc.session.cookie")

declare -A ebc_events=(
    [2024]=20
    [2025]=20
)

ebc_directory() {
    echo "everybody.codes/$year/quest$day"
}

ebc_title() {
    echo "Everybody.Codes $year - Quest $day"
}