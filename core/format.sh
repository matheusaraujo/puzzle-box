#!/bin/bash

pb_format() {
    validate_year
    validate_day
    ${challenge}_validate_directory

    local dir="$(${challenge}_directory)"
    local title="$(${challenge}_title)"

    if [[ -n "$lang" ]]; then
        execute_lang_format_sh "$dir" "$year" "$day" "$lang" "$title"
    else
        for l in "${available_languages[@]}"; do
            execute_lang_format_sh "$dir" "$year" "$day" "$lang" "$title"
        done
    fi
}

execute_lang_format_sh() {
    local dir=$1
    local year=$2
    local day=$3
    local lang=$4
    local title=$5

    print_success "format($lang): $title"
    $ROOT/langs/$lang/format.sh $dir $year $day

    if [ $? -ne 0 ]; then
        exit 1
    fi
}
