#/bin/bash

dir=$1
event=$2
puzzle=$3
part=$4
input_file=$5

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/javascript")"
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

if [ -f "$dir/requirements.txt" ]; then
    pip install -q -r "$dir/requirements.txt"
fi

python3 $ROOT/langs/python/main.py $relative_dir $event $puzzle $part < $input_file
