#!/bin/bash

pb_help() {
    echo -e "${GREEN}Usage:${NC} \`puzzle-box <command> [options]\` or simply \`pb <command> [options]\`"
    echo -e "\n${GREEN}Commands:${NC}"
    echo -e "  help                                              Show help message."
    echo -e "  create <challenge> <event> <puzzle> <language>    Create a new solution for the given challenge event, puzzle, and language."
    echo -e "  run [--watch]                                     Run the solution for the current. Use '--watch' to enable watch mode."
    echo -e "  commit                                            Commit the solution for the current problem."
    echo -e "\n${GREEN}Examples:${NC}"
    echo -e "  pb help"
    echo -e "    Show this help message."
    echo -e "  pb create ecd 2024 1 go"
    echo -e "    Create a new challenge for Everybody Codes 2024, Quest 1, using Go."
    echo -e "  pb create aoc 2001 1 perl"
    echo -e "    Create a new challenge for Advent of Code 2001, Day 1, using Perl."
    echo -e "  pb run 2001 1"
    echo -e "    Run the solution for 2001, Day 1 (the current puzzle)."
    echo -e "  pb run --watch"
    echo -e "    Run the solution for the current problem in watch mode."
    echo -e "  pb commit"
    echo -e "    Commit the solution for the current problem"
    echo -e "\n${GREEN}Starting:${NC}"
    echo -e "  Supported challenges: ${available_challenges[*]}"
    echo -e "\n${GREEN}Starting:${NC}"
    echo -e "  Supported languages: ${available_languages[*]}"
    echo -e "\n${GREEN}All available commands:${NC}"
    grep -E '^# COMMAND: ' "$0" | sed 's/# COMMAND: //' | while read -r cmd desc; do
        printf "  ${GREEN}%s${NC} %s\n" "$cmd" "$desc"
    done
}
