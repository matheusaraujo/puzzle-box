#/bin/bash

dir=$1
year=$2
day=$3
part=$4
input_file=$5

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/typescript")"
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

ts-node $ROOT/langs/typescript/main.ts $relative_dir $year $day $part < $input_file