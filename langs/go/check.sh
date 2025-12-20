#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
puzzle=$3

files=("$dir/part1.go")

if [ -f "$dir/part2.go" ]; then
    files+=("$dir/part2.go")
fi

if [ -f "$dir/part3.go" ]; then
    files+=("$dir/part3.go")
fi

if [ -f "$dir/helpers.go" ]; then
    files+=("$dir/helpers.go")
fi

output=$(go vet "${files[@]}" 2>&1)

if [ $? -ne 0 ]; then
    print_line "${PURPLE}go vet${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
    echo "$output"
    exit 1
else
    print_line "${PURPLE}go vet${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
fi
