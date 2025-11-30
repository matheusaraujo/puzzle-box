#!/bin/bash

check_custom_commit() {
    COMMIT_MSG=$(grep -E '^(chore:|Advent of Code|Everybody.Codes).+' "$1")

    if [ -z "$COMMIT_MSG" ]; then
        echo "Error: Commit message does not follow the required format."
        echo "Please use one of the following formats:"
        echo "  Advent of Code: description"
        echo "  Everybody.Codes: description"
        exit 1
    fi
}

commit_msg_file="$1"
check_custom_commit "$commit_msg_file"

exit 0
