#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.java" "part2.java" "part3.java" "helpers.java")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        output=$(pmd check --no-progress -d "$dir/$file" -R "$ROOT/langs/java/ruleset.xml" --no-cache 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}pmd check${GRAY_ITALIC} $dir/$file ${CHECK_ERROR}"
            print_line "$output"
            exit 1
        else
            print_line "${PURPLE}pmd check${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
        fi
    fi
done
