#!/bin/bash

aoc_add_session_cookie() {
    cookie=$1
    echo "$cookie" > .aoc.session.cookie

    print_line "[Advent of Code] Cookie created ${GREEN}✔${NC}"
}