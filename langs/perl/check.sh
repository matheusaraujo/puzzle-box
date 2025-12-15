#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
day=$3

files=("part1.pl" "part2.pl" "part3.pl" "helpers.pl")

for file in "${files[@]}"; do
    path="$dir/$file"
    if [ -f "$path" ]; then
        output=$(perlcritic -b "$path" --profile "$ROOT/langs/perl/.perlcriticrc" 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}perlcritic${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$output"
            exit 1
        else
            print_line "${PURPLE}perlcritic${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi
    fi
done
