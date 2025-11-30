#!/bin/bash

dir=$1

files="$ROOT/langs/java/main.java $dir/part1.java"

helpers_file="$dir/helpers.java"
if [[ -f "$helpers_file" ]]; then
    files="$files $helpers_file"
fi

part2_file="$dir/part2.java"
if [[ -f "$part2_file" ]]; then
    files="$files $part2_file"
fi

part3_file="$dir/part3.java"
if [[ -f "$part3_file" ]]; then
    files="$files $part3_file"
else
    files="$files $ROOT/langs/java/template/part3.java"
fi

javac $files
