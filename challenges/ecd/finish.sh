#!/bin/bash

ecd_finish() {
    local dir=$(ecd_directory)

    if ! ( [ -e "$dir/data/output.part1.txt" ] || [ -e "$dir/output.part2.txt" ] || [ -e "$dir/output.part3.txt" ] ); then
        print_line "puzzle is not complete yet"
        exit 1
    fi

    title=$(cat $dir/data/title.txt)

    readme_content="# Everybody Codes - ${event} Quest ${day}\n\n${title}\n\nhttps://everybody.codes/events/${event}/quests/$(echo $day | sed 's/^0*//')"
    echo -e "$readme_content" > $dir/README.md
    print_line "readme $event/day$day generated ${CHECK_SUCCESS}"

}