#!/bin/bash

source $ROOT/core/_utils.sh

ESLINT_CONFIG_PATH="/usr/local/puzzle-box/langs/typescript/eslint.config.ts"

dir="$1"
event="$2"
day="$3"
debug=0

files=("part1.ts" "part2.ts" "part3.ts" "helpers.ts")

for file in "${files[@]}"; do
    path="$dir/$file"
    if [ -f "$path" ]; then

        lint_output=$(bun x eslint "$path" --config "$ESLINT_CONFIG_PATH" 2>&1)
        status=$?

        if [ $status -ne 0 ]; then
            print_line "${PURPLE}bunx eslint${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$lint_output"
            exit 1
        else
            if [ $debug -eq 1 ]; then
                print_line "${PURPLE}bunx eslint${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
            else
                print_line "${PURPLE}bunx eslint${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
            fi
        fi
    fi
done
