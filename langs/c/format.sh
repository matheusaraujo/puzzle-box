#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
day=$3

files=("part1.c" "part2.c" "part3.c" "helpers.c")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        clang-format -i $dir/$file \
        && print_line "${PURPLE}clang-format${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done
