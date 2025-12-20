#!/bin/bash

ecd_try_to_extract_data_from_website() {
    local dir=$(ecd_directory)
    local normalized_event="${event#story}"

    if [ ! -f "$dir/data/title.txt" ]; then
        mkdir -p "$dir/data"
        retrieve_aes_keys
        response=$(curl -s \
            -H "Cookie: everybody-codes=$(cat .ecd.session.cookie)" \
            "https://everybody.codes/assets/$normalized_event/$((10#$puzzle))/description.json")

        title_encrypt=$(echo $response | jq -r '.title // empty')
        title=$(decrypt_note $title_encrypt $aes_key_1 1)
        printf "%s" "$title" > "$dir/data/title.txt"
    fi
}

