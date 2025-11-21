#!/bin/bash

source $ROOT/challenges/aoc/create.sh
source $ROOT/challenges/aoc/validate.sh

source $ROOT/challenges/ebc/create.sh
source $ROOT/challenges/ebc/validate.sh

available_challenges=(aoc ebc)

declare -A ignore_files
ignore_files=(
    ["aoc"]=".aoc.session.cookie"
    ["ebc"]=".ebc.session.cookie"
    ["global-env"]=".pb-env"
)

declare -A challenges_aliases
challenges_aliases=(
    ["aoc"]="aoc"
    ["advent-of-code"]="aoc"
    ["ebc"]="ebc"
    ["ec"]="ebc"
    ["everybody.codes"]="ebc"
)