#!/bin/bash

pb_progress() {
    setup_root_readme_file false

    print_line "hello, world"

    for challenge in "${available_challenges[@]}"; do
        events_map="${challenge}_events"
        declare -n events="$events_map"

        echo "Challenge: $challenge"

        for year in $(printf '%s\n' "${!events[@]}" | sort -n); do
            echo "  Year: $year → Events: ${events[$year]}"
        done
    done
}

# create_readme_file() {
#     touch "$README_FILE"
#     cat "<!-- progress-begin -->" >>
# }

# generate_progress_bar() {
#     local solved_days=$1
#     local total_days=25
#     local filled=$((solved_days))
#     local empty=$((total_days - solved_days))
#     local progress_bar=""

#     for ((i=0; i<filled; i++)); do
#         progress_bar+="█"
#     done

#     for ((i=0; i<empty; i++)); do
#         progress_bar+="-"
#     done

#     echo "$progress_bar"
# }

# pb_progress() {
#     emojis=("🎄" "🎅" "🎁" "❄️" "💻" "👨‍💻" "👩‍💻" "🧑‍💻" "🎉" "🧑‍🎄")

#     README_FILE="README.md"

#     progress_content="<!-- progress-begin -->\\
# | YEAR          | PROGRESS                      | COMPLETED (Out of 25) |\\
# |---------------|-------------------------------|-----------------------|"

#     for ((y=START_YEAR; y<=END_YEAR; y++)); do
#         solved_days=0

#         for d in $(seq -f "%02g" 1 25); do
#             if [ -d "$y/day$d" ] && [ -f "$y/day$d/README.md" ]; then
#                 solved_days=$((solved_days + 1))
#             fi
#         done

#         emoji=${emojis[$RANDOM % ${#emojis[@]}]}
#         progress=$(generate_progress_bar $solved_days)
#         progress_content+="\n| $emoji $y | $progress | $solved_days ($((solved_days * 100 / 25))%) |"
#     done

#     progress_content+="\n<!-- progress-end -->"

#     sed -i -e "/<!-- progress-begin -->/,/<!-- progress-end -->/c\\$progress_content" "$README_FILE"

#     print_line "progress updated! ${CHECK_SUCCESS}"
# }
