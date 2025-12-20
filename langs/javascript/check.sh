#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
puzzle=$3
debug=0

files=("part1.js" "part2.js" "part3.js" "helpers.js")


for file in "${files[@]}"; do
    path="$dir/$file"
    if [ -f "$path" ]; then

        lint_output=$(deno lint "$path" 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}deno lint${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$lint_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}deno lint${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi

        fmt_output=$(deno fmt --check "$path" 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}deno fmt --check${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$fmt_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}deno fmt --check${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi

        if [ $debug -eq 0 ]; then
            print_line "${PURPLE}deno check/fmt${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi
    fi
done