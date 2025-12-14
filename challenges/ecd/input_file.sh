#!/bin/bash

ecd_ensure_input_file_exists() {
    local dir
    dir=$(ecd_directory)

    # Verify year/day are set
    if [ -z "$year" ] || [ -z "$day" ]; then
        echo "❌ Error: year/day variables are not set before calling API."
        exit 1
    fi

    if [ ! -f "$dir/data/input.part1.txt" ] ||
       [ ! -f "$dir/data/input.part2.txt" ] ||
       [ ! -f "$dir/data/input.part3.txt" ] ||
       [ ! -f "$dir/data/output.part1.txt" ] ||
       [ ! -f "$dir/data/output.part2.txt" ] ||
       [ ! -f "$dir/data/output.part3.txt" ]; then
        retrieve_seed
        fetch_input_notes
        retrieve_aes_keys
        decode_notes
    fi
}

retrieve_seed() {
    response=$(curl -s -X GET \
        -H "Cookie: everybody-codes=$(cat .ecd.session.cookie)" \
        "https://everybody.codes/api/user/me")

    seed=$(echo "$response" | jq -r '.seed // empty')

    if [ -z "$seed" ] || [ "$seed" == "null" ]; then
        echo "❌ Error: Could not retrieve seed. Check session cookie/network."
        echo "Response was: $response"
        exit 1
    fi
}

fetch_input_notes() {
    local normalized_year="${year#story}"
    input_notes_url="https://everybody.codes/assets/$normalized_year/$((10#$day))/input/$seed.json"

    response=$(curl -s -X GET \
        -H "Cookie: everybody-codes=$(cat .ecd.session.cookie)" \
        "$input_notes_url")

    if ! echo "$response" | jq -e . &> /dev/null; then
        echo "❌ Error: Failed to fetch valid notes."
        echo "Response was: $response"
        exit 1
    fi

    encoded_note_1=$(echo "$response" | jq -r '."1" // empty')
    encoded_note_2=$(echo "$response" | jq -r '."2" // empty')
    encoded_note_3=$(echo "$response" | jq -r '."3" // empty')
}

retrieve_aes_keys() {
    local normalized_year="${year#story}"
    aes_keys_url="https://everybody.codes/api/event/$normalized_year/quest/$((10#$day))"

    response=$(curl -s -X GET \
        -H "Cookie: everybody-codes=$(cat .ecd.session.cookie)" \
        "$aes_keys_url")

    if ! echo "$response" | jq -e . &> /dev/null; then
        echo "❌ Error: Failed to fetch AES keys."
        exit 1
    fi

    aes_key_1=$(echo "$response" | jq -r '."key1" // empty')
    aes_key_2=$(echo "$response" | jq -r '."key2" // empty')
    aes_key_3=$(echo "$response" | jq -r '."key3" // empty')

    try_to_extract_answer_from_aes_keys_result "$response"
}

try_to_extract_answer_from_aes_keys_result() {
    local dir
    dir=$(ecd_directory)
    mkdir -p "$dir/data"

    local response="$1"

    local answer1=$(echo "$response" | jq -r '.answer1 // empty')
    [ -n "$answer1" ] && echo "$answer1" > "$dir/data/output.part1.txt"

    local answer2=$(echo "$response" | jq -r '.answer2 // empty')
    [ -n "$answer2" ] && echo "$answer2" > "$dir/data/output.part2.txt"

    local answer3=$(echo "$response" | jq -r '.answer3 // empty')
    [ -n "$answer3" ] && echo "$answer3" > "$dir/data/output.part3.txt"
}

decrypt_note() {
    local note="$1"
    local key_str="$2"
    local part_num="$3"

    if [ -z "$note" ] || [ -z "$key_str" ]; then
        echo "⚠️ Part $part_num: Missing note or key."
        return 1
    fi

    key_hex=$(echo -n "$key_str" | xxd -p | tr -d '\n')
    iv_raw=$(echo -n "$key_str" | head -c 16)
    iv_hex=$(echo -n "$iv_raw" | xxd -p | tr -d '\n')

    decrypted_text=$(echo -n "$note" | xxd -r -p | openssl enc -aes-256-cbc -d \
        -K "$key_hex" -iv "$iv_hex" 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$decrypted_text" ]; then
        echo "❌ Part $part_num decryption failed."
        return 1
    fi

    echo "$decrypted_text"
    return 0
}

decode_notes() {
    local dir
    dir=$(ecd_directory)
    mkdir -p "$dir/data"

    for part in 1 2 3; do
        touch "$dir/data/input.part${part}.txt"
        key_var="aes_key_$part"
        note_var="encoded_note_$part"

        if [[ -n "${!key_var}" ]]; then
            decrypt_note "${!note_var}" "${!key_var}" "$part" > "$dir/data/input.part${part}.txt"
            if [ $? -ne 0 ]; then
                echo "⚠️ Part $part failed to decrypt."
                rm -f "$dir/data/input.part${part}.txt"
            fi
        else
            rm -f "$dir/data/input.part${part}.txt"
        fi
    done
}
