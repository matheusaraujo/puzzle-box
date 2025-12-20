#!/bin/bash

source $ROOT/core/_utils.sh
dir=$1

files=("part1.cpp" "part2.cpp" "part3.cpp" "helpers.cpp")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        clang-format -i "$dir/$file" \
        && print_line "${PURPLE}clang-format${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done