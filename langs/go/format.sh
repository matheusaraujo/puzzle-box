#!/bin/bash

dir=$1
year=$2
day=$3

files=("part1.go" "part2.go" "part3.go" "helpers.go")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        gofmt -w $dir/$file && echo -e "gofmt $dir/$file \033[32m✔\033[0m"
    fi
done
