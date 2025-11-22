#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

if [ -f "$dir/requirements.txt" ]; then
    pip install -q -r "$dir/requirements.txt"
fi

files=("part1.py" "part2.py" "part3.py" "helpers.py")

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        isort $dir/$file \
        && black $dir/$file -l 88 -q \
        && print_line "${PURPLE}isort/black${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
    fi
done
