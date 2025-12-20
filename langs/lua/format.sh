#!/bin/bash
source $ROOT/core/_utils.sh
dir=$1

if command -v stylua &> /dev/null; then
    stylua "$dir"/*.lua && \
    print_line "${PURPLE}stylua${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
else
    print_line "${PURPLE}stylua not found${CHECK_ERROR}"
fi