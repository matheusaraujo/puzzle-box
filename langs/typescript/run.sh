#!/bin/bash

dir=$1
part=$2
input_file=$3

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/typescript")" # New language base path
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

bun run "$ROOT/langs/typescript/main.ts" $relative_dir $part < "$input_file"