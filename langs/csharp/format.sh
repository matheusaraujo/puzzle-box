#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.cs" "part2.cs" "part3.cs" "helpers.cs")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        csharpier format $dir/$file && print_success "csharpier format $dir/$file \033[32m✔\033[0m"
    fi
done
