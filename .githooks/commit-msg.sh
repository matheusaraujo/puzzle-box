#!/bin/bash

check_custom_commit() {
    COMMIT_MSG=$(grep -E '^(Advent of Code|Everybody Codes) \([0-9]{4}\): .+' "$1")

    if [ -z "$COMMIT_MSG" ]; then
        echo "Error: Commit message does not follow the required format."
        echo "Please use one of the following formats:"
        echo "  Advent of Code (YEAR): description"
        echo "  Everybody Codes (YEAR): description"
        exit 1
    fi
}

commit_msg_file="$1"
check_custom_commit "$commit_msg_file"

exit 0
