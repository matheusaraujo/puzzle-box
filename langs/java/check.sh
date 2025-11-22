#!/bin/bash

source lib/aoc/utils.sh

year=$1
day=$2

files=("part1.java" "part2.java" "helpers.java")

for file in "${files[@]}"; do
    if [ -f "$year/day$day/$file" ]; then
        pmd check -d $year/day$day/$file -R lib/java/ruleset.xml --no-cache
        if [ $? -ne 0 ]; then
            exit 1
        else
            print_line "pmd check $year/day$day/$file ${CHECK_SUCCESS}"
        fi
    fi
done
