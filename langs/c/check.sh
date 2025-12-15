#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
day=$3
debug=0

files=("part1.c" "part2.c" "part3.c" "helpers.c")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        output=$(clang --analyze -fcolor-diagnostics -Werror -I$ROOT/langs/c "$dir/$file" 2>&1)
        if [ -n "$output" ]; then
            print_line "${PURPLE}clang --analyze${GRAY_ITALIC} $dir/$file ${CHECK_ERROR}"
            print_line "$output"
            exit 1
        elif [ $debug -eq 1 ]; then
            echo -e "${PURPLE}clang --analyze ${GRAY_ITALIC}$dir/$file ${CHECK_SUCCESS}"
        fi

        tidy_output=$(clang-tidy "$dir/$file" -extra-arg=-w --quiet --use-color --config-file=$ROOT/langs/c/.clang-tidy -- -I$ROOT/langs/c -std=c11 2>&1)
        if [[ -n "$tidy_output" && ! "$tidy_output" =~ ^[0-9]+[[:space:]]+warnings[[:space:]]+generated\.$ ]]; then
            print_line "${PURPLE}clang-tidy${GRAY_ITALIC} $dir/$file ${CHECK_ERROR}"
            print_line "$tidy_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}clang-tidy${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
            rm -rf *.plist
        else
            print_line "${PURPLE}clang --analyze/clang-tidy${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
            rm -rf *.plist
        fi
    fi
done
