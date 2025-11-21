#!/bin/bash

aoc_try_to_extract_answers_from_website() {
    local dir=$(aoc_directory)
    curl -s -b session=$(cat .aoc.session.cookie) https://adventofcode.com/$year/day/$(echo $day | sed 's/^0*//') -o $dir/_readme1.html
    if [ -f "$dir/_readme1.html" ]; then

        answers=($(grep -oP '<p>Your puzzle answer was <code>\K[^<]+' $dir/_readme1.html))
        if [ ${#answers[@]} -ne 0 ]; then
            mkdir -p $dir/data

            printf "%s" "${answers[0]}" > $dir/data/output.part1.txt
            if [ ${#answers[@]} -eq 2 ]; then
                printf "%s" "${answers[1]}" > $dir/data/output.part2.txt
            fi

        fi

        rm -rf $dir/_readme*.html

    fi
}