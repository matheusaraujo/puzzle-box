#!/bin/bash

ebc_finish() {
    local dir=$(ebc_directory)

    if ! ( [ -e "$dir/data/output.part1.txt" ] || [ -e "$dir/output.part2.txt" ] || [ -e "$dir/output.part3.txt" ] ); then
        print_line "puzzle is not complete yet"
        exit 1
    fi

    readme_content="# Everybody Codes - ${year} Quest ${day}\n\n${extracted_title}\n\nhttps://adventofcode.com/${year}/day/$(echo $day | sed 's/^0*//')"
    echo -e "$readme_content" > $dir/README.md
    print_line "readme $year/day$day generated ${CHECK_SUCCESS}"

}