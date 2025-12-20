#!/bin/bash

source $ROOT/core/_utils.sh
dir=$1

output=$(luacheck "$dir"/*.lua 2>&1)

if [ $? -ne 0 ]; then
    print_line "${PURPLE}luacheck${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
    echo "$output"
    exit 1
else
    print_line "${PURPLE}luacheck${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
fi