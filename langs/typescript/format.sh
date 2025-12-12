#!/bin/bash

source $ROOT/core/_utils.sh

BUNX_EXEC="/usr/local/bin/bun x"

dir=$1
year=$2
day=$3

files=("part1.ts" "part2.ts" "part3.ts" "helpers.ts")

for file in "${files[@]}"; do
    FILE_PATH="$dir/$file"
    if [ -f "$FILE_PATH" ]; then
        bun x prettier "$FILE_PATH" --write --log-level silent \
        && print_line "${PURPLE}bun x prettier${GRAY_ITALIC} $FILE_PATH ${CHECK_SUCCESS}"
    fi
done