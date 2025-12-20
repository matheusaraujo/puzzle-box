#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
puzzle=$3

files=("part1.js" "part2.js" "part3.js" "helpers.js")

for file in "${files[@]}"; do
    FILE_PATH="$dir/$file"
    if [ -f "$FILE_PATH" ]; then
        deno fmt "$FILE_PATH" --quiet \
        && print_line "${PURPLE}deno fmt${GRAY_ITALIC} $FILE_PATH ${CHECK_SUCCESS}"
    fi
done