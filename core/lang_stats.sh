#!/bin/bash

pb_lang_stats() {
    local readme_file="README.md"
    declare -A lang_count

    for lang in "${available_languages[@]}"; do
        lang_count[$lang]=0
    done

    for challenge in "${available_challenges[@]}"; do
        events_map="${challenge}_events"
        declare -n events="$events_map"

        for year in $(printf '%s\n' "${!events[@]}" | sort -nr); do
            local max_day=${events[$year]}
            for ((day=1; day<=max_day; day++)); do
                local dir="$(${challenge}_directory)"
                if [[ -d "$dir" ]]; then
                    for lang in "${available_languages[@]}"; do
                        ext="${languages_extensions[$lang]}"
                        if [[ -f "$dir/part1.$ext" ]]; then
                            lang_count[$lang]=$((lang_count[$lang] + 1))
                        fi
                    done
                fi
            done
        done
    done

    sorted_langs=$(for lang in "${available_languages[@]}"; do
        echo "$lang ${lang_count[$lang]}"
    done | sort -k2 -nr)

    lang_stats_content="<!-- langs-stats-begin -->\n## Language stats\n"
    lang_stats_content+="| Language | Problems solved |\n"
    lang_stats_content+="|----------|-----------------|\n"
    while IFS=' ' read -r lang count; do
        lang_stats_content+="| \`$lang\` | $count |\n"
    done <<< "$sorted_langs"
    lang_stats_content+="<!-- langs-stats-end -->"

    sed -i -e "/<!-- langs-stats-begin -->/,/<!-- langs-stats-end -->/c\\$lang_stats_content" "$readme_file"

    print_line "Language statistics list in README updated! ${CHECK_SUCCESS}"
}
