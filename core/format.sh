#!/bin/bash

execute_lang_format_sh() {
    local dir=$1
    local event=$2
    local day=$3
    local lang=$4
    local title=$5
    local ext=${languages_extensions[$lang]}

    if [[ -f "$dir/part1.$ext" ]]; then
        print_line "format($lang): $title"
        $ROOT/langs/$lang/format.sh $dir $event $day

        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
}

pb_format() {
    validate_event
    validate_day
    ${challenge}_validate_directory

    local dir="$(${challenge}_directory)"
    local title="$(${challenge}_problem_title)"

    if [[ -n "$lang" ]]; then
        execute_lang_format_sh "$dir" "$event" "$day" "$lang" "$title"
    else
        for ((i=0; i<${#available_languages[@]}; i++)); do
            l="${available_languages[$i]}"
            execute_lang_format_sh "$dir" "$event" "$day" "$l" "$title"
        done
    fi
}

pb_format_event() {
    validate_challenge
    validate_event

    declare -n events="${challenge}_events"
    local max_days="${events[$event]}"
    for day in $(seq -w 1 "$max_days"); do
        local dir="$(${challenge}_directory)"
        if [ -d "$dir" ]; then
            pb_format || {
                echo -e "${RED}[ERROR] Format failed for $challenge: $event - $day${NC}"
                exit 1
            }
            print_line "----------------------------------------------------------------------"
        fi
    done
}

pb_format_challenge() {
    validate_challenge

    declare -n events="${challenge}_events"
    for event in "${!events[@]}"; do
        pb_format_event
    done
}

pb_format_all() {
    for challenge in "${available_challenges[@]}"; do
        pb_format_challenge
    done
}

