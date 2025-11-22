#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.pl" "part2.pl" "part3.pl" "helpers.pl")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        perltidy -b $dir/$file \
        && print_success "${PURPLE}perltidy${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done
