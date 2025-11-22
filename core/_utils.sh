#!/bin/bash

# Color and stdout definitions
GREEN="\033[0;32m"
NC="\033[0m"
RED="\033[0;31m"
PURPLE="\033[35m"
GRAY_ITALIC="\033[3;90m"
CHECK_SUCCESS="\033[32m✔\033[0m"

START_YEAR=2015
END_YEAR=2025

print_success() {
    local message=$1
    echo -e "$message"
}

print_error() {
    local message=$1
    echo -e "$message"
}

print_empty_line() {
    echo ""
}
