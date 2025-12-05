#!/bin/bash

pb_version() {
    echo "[linux]"
    cat /etc/os-release

    print_empty_line
    echo "[puzzle-box]"
    echo "puzzle-box@0.0.6"

    for lang in "${available_languages[@]}"; do
        if [ -f "$ROOT/langs/$lang/version.sh" ]; then
            print_empty_line
            $ROOT/langs/$lang/version.sh
        fi
    done
}

