#!/bin/bash

pb_commit() {
    validate_challenge
    validate_year
    validate_day
    ${challenge}_validate_directory

    pb_format
    pb_check
    pb_run
    pb_finish
    pb_progress
    pb_lang_stats

    local problem_folder="$(${challenge}_directory)"
    local problem_title="$(${challenge}_problem_title)"
    local challenge_title=${challenges_titles[$challenge]}

    local readme_path="$problem_folder/README.md"
    local root_readme_path="README.md"

    if [ ! -f "$readme_path" ]; then
        print_line "Error: README.md file does not exist at $readme_path"
        exit 1
    fi

    changed_files=($(git status --porcelain | awk '{print $2}'))
    if [[ ${#changed_files[@]} -ne 2 || "${changed_files[0]}" != "$root_readme_path" || ("${changed_files[1]}" != "$problem_folder" && "${changed_files[1]}" != "${problem_folder%%/*}/" ) ]]; then
        print_line "Error: Unexpected changes detected. Expected only:\n 1. $root_readme_path\n 2. $problem_folder"
        exit 1
    fi

    git add "$root_readme_path"
    git add "$problem_folder"
    git commit -m "$problem_title"

    print_line "code committed! ${CHECK_SUCCESS}"
}
