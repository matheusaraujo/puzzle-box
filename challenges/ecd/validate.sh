#!/bin/bash

ecd_validate_year_day() {
    day_num=$((10#$day))

    if [[ -n "${ecd_events[$year]}" ]]; then
        max_day=${ecd_events[$year]}
        if [ "$day_num" -ge 1 ] && [ "$day_num" -le "$max_day" ]; then
            return 0
        fi
    fi

    print_line "${RED}[Everybody.Codes] Invalid year ($year) or day ($day).${NC}"
    exit 1
}

ecd_validate_directory() {
    if [ ! -d "everybody.codes/$year/quest$day" ]; then
        print_line "${RED}[Everybody.Codes] Directory does not exist for $year, quest $day.${NC}"
        exit 1
    fi
}

ecd_validate_part() {
    if [ -z "$part" ]; then
        print_line "${RED}[ERROR] Part must be defined (part1, part2, part3).${NC}"
        exit 1
    elif [[ "$part" != "part1" && "$part" != "part2" && "$part" != "part3" ]]; then
        print_line "${RED}[ERROR] Part must be either part1, part2 or part3.${NC}"
        exit 1
    fi
}