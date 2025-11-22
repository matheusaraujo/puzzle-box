#!/bin/bash

aoc_create() {
    local ext=${languages_extensions[$lang]}
    local dir=$(aoc_directory)
    mkdir -p $dir/data
    if [ -e $dir/part1.$ext ] || [ -e $dir/part2.$ext ]; then
        print_line "Error: part1.$ext or part2.$ext already exists in $dir"
        exit 1
    fi
    cp -r $ROOT/langs/$lang/template/part1.$ext $dir
    cp -r $ROOT/langs/$lang/template/part2.$ext $dir
    print_line "[Advent of Code] $dir created using $lang! ${GREEN}✔${NC}"
    print_line "Great coding! 💻"
}