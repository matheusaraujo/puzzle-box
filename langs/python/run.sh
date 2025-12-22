#/bin/bash

dir=$1
part=$2
input_file=$3

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/javascript")"
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

if [ -f "$dir/requirements.txt" ]; then
    pip install -q -r "$dir/requirements.txt"
fi

python3 $ROOT/langs/python/main.py $relative_dir $part < $input_file
