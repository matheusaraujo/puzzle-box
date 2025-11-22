#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.go" "part2.go" "part3.go" "helpers.go")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        gofmt -w $dir/$file \
        && print_line "${PURPLE}gofmt -w${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done
