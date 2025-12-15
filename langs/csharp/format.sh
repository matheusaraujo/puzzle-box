#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
day=$3

files=("part1.cs" "part2.cs" "part3.cs" "helpers.cs")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        csharpier format $dir/$file --log-level none \
        && print_line "${PURPLE}csharpier format${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done
