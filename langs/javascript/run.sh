#/bin/bash

dir=$1
part=$2
input_file=$3

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/javascript")"
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

deno run --allow-all $ROOT/langs/javascript/main.js $relative_dir $part < $input_file