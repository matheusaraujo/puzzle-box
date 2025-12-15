#!/bin/bash

dir=$1
event=$2
day=$3
part=$4
input_file=$5

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/typescript")" # New language base path
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

bun run "$ROOT/langs/typescript/main.ts" $relative_dir $event $puzzle $part < "$input_file"