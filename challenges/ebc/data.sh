#!/bin/bash

ebc_try_to_extract_data_from_website() {
    local dir=$(ebc_directory)

    if [ ! -f "$dir/data/title.txt" ]; then
        mkdir -p "$dir/data"
        retrieve_aes_keys
        response=$(curl -s \
            -H "Cookie: everybody-codes=$(cat .ebc.session.cookie)" \
            "https://everybody.codes/assets/$year/$((10#$day))/description.json")

        title_encrypt=$(echo $response | jq -r '.title // empty')
        title=$(decrypt_note $title_encrypt $aes_key_1 1)
        printf "%s" "$title" > "$dir/data/title.txt"
    fi
}

