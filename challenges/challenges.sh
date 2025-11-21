#!/bin/bash

available_challenges=(aoc ec)

declare -A ignore_files
ignore_files=(
    ["aoc"]=".aoc.session.cookie"
    ["ec"]=".ec.session.cookie"
    ["global-env"]=".pb-env"
)

declare -A challenges_aliases
challenges_aliases=(
    ["aoc"]="aoc"
    ["advent-of-code"]="aoc"
    ["ec"]="ec"
    ["everybody.codes"]="ec"
)