#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
day=$3

if [ -f "$dir/requirements.txt" ]; then
    pip install -q -r "$dir/requirements.txt"
fi

files=("part1.py" "part2.py" "part3.py" "helpers.py")

for file in "${files[@]}"; do
    path="$dir/$file"
    if [ -f "$path" ]; then
        output=$( pylint $path --rcfile=$ROOT/langs/python/.pylintrc 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}pylint ${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$output"
            exit 1
        else
            print_line "${PURPLE}pylint ${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi
    fi
done
