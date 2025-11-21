#!/bin/bash

ebc_validate_year_day() {
    day_num=$((10#$day))

    declare -A days=(
        [2024]=20
        [2025]=20
    )

    if [[ -n "${days[$year]}" ]]; then
        max_day=${days[$year]}
        if [ "$day_num" -ge 1 ] && [ "$day_num" -le "$max_day" ]; then
            return 0
        fi
    fi

    print_error "${RED}[Everybody.Codes] Invalid year ($year) or day ($day).${NC}"
    exit 1
}

ebc_validate_directory() {
    if [ ! -d "everybody.codes/$year/quest$day" ]; then
        print_error "${RED}[Everybody.Codes] Directory does not exist for $year, quest $day.${NC}"
        exit 1
    fi
}