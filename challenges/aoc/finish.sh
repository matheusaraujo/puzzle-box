#!/bin/bash

aoc_finish() {
    local dir=$(aoc_directory)

    mkdir -p $dir/data

    curl -s -b session=$(cat .aoc.session.cookie) https://adventofcode.com/$year/day/$(echo $day | sed 's/^0*//') -o $dir/data/_readme1.html

    if ! grep -q '<p class="day-success">Both parts of this puzzle are complete!' $dir/data/_readme1.html; then
        print_line "puzzle is not complete yet"
        exit 1
    fi

    answers=($(grep -oP '<p>Your puzzle answer was <code>\K[^<]+' $dir/data/_readme1.html))
    if [ ${#answers[@]} -eq 0 ]; then
        print_line "Error: Unable to extract any answers"
        exit 1
    fi

    printf "%s" "${answers[0]}" > $dir/data/output.part1.txt
    if [ ${#answers[@]} -eq 2 ]; then
        printf "%s" "${answers[1]}" > $dir/data/output.part2.txt
    fi

    if [ "${_AOC_FORCE_PUZZLE_TEXT:-}" == "true" ]; then
        echo -e "\e[31m⚠️ DISCLAIMER ⚠️\e[0m"
        echo -e "\e[33m⚠️ WARNING: According to the Advent of Code FAQ (https://adventofcode.com/2024/about#faq_copying), this action is discouraged.\e[0m"
        echo -e "\e[33m⚠️ Proceed at your own risk.\e[0m"

        sed -n '/<main>/,/<\/main>/p' $dir/data/_readme1.html > $dir/data/_readme2.html
        sed '/<p class="day-success">Both parts of this puzzle are complete!/q' $dir/data/_readme2.html | sed '$a</main>' > $dir/data/_readme3.html
        pandoc --from=html --to=markdown --output=$dir/README.md $dir/data/_readme3.html
        sed -i 's/::: {role="main"}//g' $dir/README.md
        sed -i 's/{#part2}//g' $dir/README.md
        sed -i '${/^:::$/d}' $dir/README.md
        print_line "readme $year/day$day generated ${CHECK_SUCCESS}"
    else
        sed -n '/<main>/,/<\/main>/p' $dir/data/_readme1.html > $dir/data/_readme2.html
        title=$(cat $dir/data/title.txt)
        readme_content="# Advent of Code - ${year} Day ${day}\n\n${title}\n\nhttps://adventofcode.com/${year}/day/$(echo $day | sed 's/^0*//')"
        echo -e "$readme_content" > $dir/README.md
        print_line "readme $year/day$day generated ${CHECK_SUCCESS}"
    fi

    rm $dir/data/_readme*.html
}