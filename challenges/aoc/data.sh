#!/bin/bash

aoc_try_to_extract_data_from_website() {
    local dir=$(aoc_directory)
    mkdir -p "$dir/data"

    file_path="$dir/data/_readme1.html"

    curl -s -b session=$(cat .aoc.session.cookie) \
        "https://adventofcode.com/$event/day/$(echo $day | sed 's/^0*//')" \
        -o "$file_path"

    if [ -f "$file_path" ]; then

        title=$(grep -oP '<h2>--- Day [0-9]+: \K.*(?= ---)' "$file_path" | sed 's/[[:space:]]*$//' | sed "s/&apos;/'/g; s/&quot;/\"/g; s/&amp;/\&/g")
        if [ -n "$title" ]; then
            printf "%s" "$title" > "$dir/data/title.txt"
        fi

        answers=($(grep -oP '<p>Your puzzle answer was <code>\K[^<]+' "$file_path"))
        if [ ${#answers[@]} -ne 0 ]; then
            printf "%s" "${answers[0]}" > "$dir/data/output.part1.txt"
            if [ ${#answers[@]} -eq 2 ]; then
                printf "%s" "${answers[1]}" > "$dir/data/output.part2.txt"
            fi
        fi

        # rm -f "$file_path"
    fi
}
