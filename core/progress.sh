#!/bin/bash

pb_progress() {
    setup_root_readme_file false

    local progress_content=""
    local readme_file="README.md"

    for challenge in "${available_challenges[@]}"; do
        events_map="${challenge}_events"
        declare -n events="$events_map"
        local challenge_title=${challenges_titles[$challenge]}

        progress_content+="\n## $challenge_title\n"
        progress_content+="| Event | Completed | Progress |\n"
        progress_content+="|------|-----------|----------|\n"

        for event in $(printf '%s\n' "${!events[@]}" | sort -nr); do
            local max_day=${events[$event]}
            local done_count=0
            local day_line=""

            for ((day=1; day<=max_day; day++)); do
                local dir="$(${challenge}_directory)"
                if [[ -f "$dir/README.md" ]]; then
                    ((done_count++))
                    day_line+="✅"
                else
                    day_line+="⬜"
                fi
            done

            progress_content+="| $event | $done_count / $max_day | $day_line |\n"
        done
    done

    sed -i -e "/<!-- progress-begin -->/,/<!-- progress-end -->/c\\
<!-- progress-begin -->\\
$progress_content\\
<!-- progress-end -->" "$readme_file"

    print_line "Progress in README updated! ${CHECK_SUCCESS}"
}
