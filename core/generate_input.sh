#/bin/bash

aoc_generate_input() {
    validate_year_day_directory_part

    letter=$(ls $year/day$day/data/input.$part.*.txt 2>/dev/null | wc -l | awk '{printf "%c", 97 + $1}')

    print_line "input(Ctrl+D to finish):"
    input=$(cat)

    mkdir -p $year/day$day/data
    echo "$input" > $year/day$day/data/input.$part.$letter.txt

    print_line "\noutput:"
    read output

    echo "$output" > $year/day$day/data/output.$part.$letter.txt

}
