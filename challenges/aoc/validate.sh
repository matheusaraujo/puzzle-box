#!/bin/bash

aoc_validate() {
    day_num=$((10#$day))

    declare -A days=(
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

    if [[ -n "${days[$year]}" ]]; then
        max_day=${days[$year]}
        if [ "$day_num" -ge 1 ] && [ "$day_num" -le "$max_day" ]; then
            return 0
        fi
    fi

    print_error "${RED}[Advent of Code] Invalid year ($year) or day ($day).${NC}"
    exit 1
}