#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.c" "part2.c" "part3.c" "helpers.c")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        clang-format -i $dir/$file && print_success "clang-format $dir/$file \033[32m✔\033[0m"
    fi
done
