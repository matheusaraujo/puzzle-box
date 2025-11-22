#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3
debug=0

files=("part1.js" "part2.js" "part3.js" "helpers.js")

npm_output=$(npm --silent --prefix "$ROOT/langs/javascript/" install "$ROOT/langs/javascript/" 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}npm install${GRAY_ITALIC} javascript/ ${CHECK_ERROR}"
    print_line "$npm_output"
    exit 1
elif [ $debug -eq 1 ]; then
    print_line "${PURPLE}npm install${GRAY_ITALIC} javascript/ ${CHECK_SUCCESS}"
fi

for file in "${files[@]}"; do
    path="$dir/$file"
    if [ -f "$path" ]; then
        eslint_output=$(npx eslint "$path" --config "$ROOT/langs/javascript/eslint.config.mjs" 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}eslint${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$eslint_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}eslint${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi

        prettier_output=$(prettier "$path" --check 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}prettier --check${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$prettier_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}prettier --check${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        else
            print_line "${PURPLE}eslint/prettier --check${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi
    fi
done
