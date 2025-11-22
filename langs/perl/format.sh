#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.pl" "part2.pl" "part3.pl" "helpers.pl")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        perltidy -b $dir/$file && echo -e "perltidy $dir/$file \033[32m✔\033[0m"
    fi
done
