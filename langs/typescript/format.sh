#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.ts" "part2.ts" "part3.ts" "helpers.ts")

npm --silent --prefix $ROOT/langs/typescript/ install $ROOT/langs/typescript/

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        prettier "$dir/$file" --write --log-level silent \
        && print_line "${PURPLE}prettier${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done