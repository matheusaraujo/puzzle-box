#!/bin/bash

source $ROOT/core/_utils.sh

rust_dir="$ROOT/langs/rust"

cargo fmt --manifest-path "$rust_dir/Cargo.toml"
print_line "${PURPLE}cargo fmt${GRAY_ITALIC} $rust_dir/src/ ${CHECK_SUCCESS}"
