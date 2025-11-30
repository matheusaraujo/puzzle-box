#!/bin/bash

execute_lang_check_sh() {
    local dir=$1
    local year=$2
    local day=$3
    local lang=$4
    local title=$5
    local ext=${languages_extensions[$lang]}

    if [[ -f "$dir/part1.$ext" ]]; then

        print_line "check($lang): $title"
        $ROOT/langs/$lang/check.sh $dir $year $day

        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
}

pb_check() {
    validate_challenge
    validate_year
    validate_day
    ${challenge}_validate_directory

    local dir="$(${challenge}_directory)"
    local title="$(${challenge}_problem_title)"

    if [[ -n "$lang" ]]; then
        execute_lang_check_sh "$dir" "$year" "$day" "$lang" "$title"
    else
        for ((i=0; i<${#available_languages[@]}; i++)); do
            l="${available_languages[$i]}"
            execute_lang_check_sh "$dir" "$year" "$day" "$l" "$title"
        done
    fi
}

pb_check_year() {
    validate_challenge
    validate_year

    for day in $POTENTIAL_DAYS; do
        local dir="$(${challenge}_directory)"
        if [ -d "$dir" ]; then
            pb_check || {
                echo -e "${RED}[ERROR] Check failed for $challenge: $year - $day${NC}"
                exit 1
            }
            print_line "----------------------------------------------------------------------"
        fi
    done
}

pb_check_challenge() {
    validate_challenge

    for year in $POTENTIAL_YEARS; do
        pb_check_year
    done
}

pb_check_all() {
    for challenge in "${available_challenges[@]}"; do
        pb_check_challenge
    done
}