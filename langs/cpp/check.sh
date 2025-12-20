#!/bin/bash

source $ROOT/core/_utils.sh
dir=$1

files=("$dir/part1.cpp")
[ -f "$dir/part2.cpp" ] && files+=("$dir/part2.cpp")
[ -f "$dir/part3.cpp" ] && files+=("$dir/part3.cpp")
[ -f "$dir/helpers.cpp" ] && files+=("$dir/helpers.cpp")

output=$(g++ -fsyntax-only -Wall "${files[@]}" 2>&1)

if [ $? -ne 0 ]; then
    print_line "${PURPLE}g++ check${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
    echo "$output"
    exit 1
else
    print_line "${PURPLE}g++ check${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
fi