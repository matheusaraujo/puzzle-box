#!/bin/bash

set -e

dir="$1"

part1_file="$dir/part1.c"

helpers_file=""
if [ -f "$dir/helpers.c" ]; then
    helpers_file="$dir/helpers.c"
fi

if [ -f "$dir/part2.c" ]; then
    part2_file="$dir/part2.c"
else
    part2_file="$ROOT/langs/c/template/part2.c"
fi

if [ -f "$dir/part3.c" ]; then
    part3_file="$dir/part3.c"
else
    part3_file="$ROOT/langs/c/template/part3.c"
fi

if ! gcc -o "$ROOT/langs/c/run" \
    -I"$ROOT/langs/c" \
    $helpers_file \
    "$ROOT/langs/c/pb_helpers.c" \
    "$part1_file" \
    "$part2_file" \
    "$part3_file" \
    "$ROOT/langs/c/main.c"; then
    echo "Build failed."
    exit 1
fi
