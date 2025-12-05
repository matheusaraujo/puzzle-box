#!/bin/bash
source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

workspace_dir="$(pwd)/$dir"
rust_dir="$ROOT/langs/rust"
cd "$rust_dir"

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

output=$(cargo check --manifest-path "$rust_dir/Cargo.toml" 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}cargo check${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
    echo "$output"
    exit 1
else
    print_line "${PURPLE}cargo check${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
fi

output=$(cargo clippy --manifest-path "$rust_dir/Cargo.toml" -- -D warnings 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}cargo clippy${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
    echo "$output"
    exit 1
else
    print_line "${PURPLE}cargo clippy${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
fi
