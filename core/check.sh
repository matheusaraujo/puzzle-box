#!/bin/bash

execute_lang_check_sh() {
    local dir=$1
    local event=$2
    local puzzle=$3
    local lang=$4
    local title=$5
    local ext=${languages_extensions[$lang]}

    if [[ -f "$dir/part1.$ext" ]]; then

        print_line "check($lang): $title"
        $ROOT/langs/$lang/check.sh $dir $event $puzzle

        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
}

pb_check() {
    validate_challenge
    validate_event
    validate_puzzle
    ${challenge}_validate_directory

    local dir="$(${challenge}_directory)"
    local title="$(${challenge}_problem_title)"

    if [[ -n "$lang" ]]; then
        execute_lang_check_sh "$dir" "$event" "$puzzle" "$lang" "$title"
    else
        for ((i=0; i<${#available_languages[@]}; i++)); do
            l="${available_languages[$i]}"
            execute_lang_check_sh "$dir" "$event" "$puzzle" "$l" "$title"
        done
    fi
}

pb_check_event() {
    validate_challenge
    validate_event

    declare -n events="${challenge}_events"
    local last_puzzle="${events[$event]}"
    for puzzle in $(seq -w 1 "$last_puzzle"); do
        puzzle=$(printf "%02d" "$((10#$puzzle))")
        local dir="$(${challenge}_directory)"
        if [ -d "$dir" ]; then
            pb_check || {
                echo -e "${RED}[ERROR] Check failed for $challenge: $event - $puzzle${NC}"
                exit 1
            }
            print_line "----------------------------------------------------------------------"
        fi
    done
}

pb_check_challenge() {
    validate_challenge

    declare -n events="${challenge}_events"
    for event in "${!events[@]}"; do
        pb_check_event
    done
}

pb_check_all() {
    for challenge in "${available_challenges[@]}"; do
        pb_check_challenge
    done
}