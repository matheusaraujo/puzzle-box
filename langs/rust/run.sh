#!/bin/bash

set -euo pipefail

dir=$1
event=$2
day=$3
part=$4
input_file=$5

workspace_dir="$(pwd)/$dir"
rust_dir="$ROOT/langs/rust"

ln -sf "$workspace_dir/part1.rs" "$rust_dir/src/part1.rs"

if [ -f "$workspace_dir/part2.rs" ]; then
    ln -sf "$workspace_dir/part2.rs" "$rust_dir/src/part2.rs"
else
    ln -sf "$rust_dir/template/part2.rs" "$rust_dir/src/part2.rs"
fi

if [ -f "$workspace_dir/part3.rs" ]; then
    ln -sf "$workspace_dir/part3.rs" "$rust_dir/src/part3.rs"
else
    ln -sf "$rust_dir/template/part3.rs" "$rust_dir/src/part3.rs"
fi

if [ -f "$workspace_dir/helpers.rs" ]; then
    ln -sf "$workspace_dir/helpers.rs" "$rust_dir/src/helpers.rs"
else
    ln -sf "$rust_dir/template/helpers.rs" "$rust_dir/src/helpers.rs"
fi

cargo run --manifest-path "$rust_dir/Cargo.toml" --quiet -- "$dir" "$event" "$day" "$part" < "$input_file"