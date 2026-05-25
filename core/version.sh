#!/bin/bash

pb_get_version() {
    if [ -n "${PUZZLE_BOX_VERSION:-}" ]; then
        echo "$PUZZLE_BOX_VERSION"
    elif [ -f "$ROOT/VERSION" ]; then
        cat "$ROOT/VERSION"
    else
        echo "dev"
    fi
}

pb_version() {
    echo "[linux]"
    cat /etc/os-release

    print_empty_line
    echo "[puzzle-box]"
    echo "puzzle-box@$(pb_get_version)"

    for lang in "${available_languages[@]}"; do
        if [ -f "$ROOT/langs/$lang/version.sh" ]; then
            print_empty_line
            "$ROOT/langs/$lang/version.sh"
        fi
    done
}
