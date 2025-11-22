#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.java" "part2.java" "part3.java" "helpers.java")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        java -jar /usr/local/bin/google-java-format -i $dir/$file && print_success "google-java-format $dir/$file \033[32m✔\033[0m"
    fi
done
