#!/bin/bash

ebc_try_to_extract_data_from_website() {
    local dir=$(ebc_directory)
    mkdir -p "$dir/data"

    file_path="$dir/data/_readme1.html"

    curl -s \
        -H "Cookie: everybody-codes=$(cat .ebc.session.cookie)" \
        "https://everybody.codes/event/$year/quests/$$((10#$day))" \
        -o "$file_path"

    if [ -f "$file_path" ]; then

        title=$(grep -oP '<h2>\Quest([^<]+)' "$file_path" \
            | head -n 1 \
            | sed 's/[[:space:]]*$//' \
            | sed "s/&apos;/'/g; s/&quot;/\"/g; s/&amp;/\&/g")

        if [ -n "$title" ]; then
            printf "%s" "$title" > "$dir/data/title.txt"
        fi
    fi
}