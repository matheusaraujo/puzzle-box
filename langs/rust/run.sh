#!/bin/bash

set -euo pipefail

dir=$1
part=$2
input_file=$3

workspace_dir="$(pwd)/$dir"
rust_dir="$ROOT/langs/rust"

cleanup() {
    rm -f "$rust_dir/src/part1.rs" \
          "$rust_dir/src/part2.rs" \
          "$rust_dir/src/part3.rs" \
          "$rust_dir/src/helpers.rs"

    cargo clean --manifest-path "$rust_dir/Cargo.toml" --quiet
}

trap cleanup EXIT

ln -sf "$workspace_dir/part1.rs" "$rust_dir/src/part1.rs"

for i in 2 3; do
    if [ -f "$workspace_dir/part$i.rs" ]; then
        ln -sf "$workspace_dir/part$i.rs" "$rust_dir/src/part$i.rs"
    else
        ln -sf "$rust_dir/template/part$i.rs" "$rust_dir/src/part$i.rs"
    fi
done

if [ -f "$workspace_dir/helpers.rs" ]; then
    ln -sf "$workspace_dir/helpers.rs" "$rust_dir/src/helpers.rs"
else
    ln -sf "$rust_dir/template/helpers.rs" "$rust_dir/src/helpers.rs"
fi

cargo run --manifest-path "$rust_dir/Cargo.toml" --quiet -- "$dir" "$part" < "$input_file"