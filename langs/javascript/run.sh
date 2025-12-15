#/bin/bash

dir=$1
event=$2
day=$3
part=$4
input_file=$5

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/javascript")"
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

deno run --allow-all $ROOT/langs/javascript/main.js $relative_dir $event $day $part < $input_file