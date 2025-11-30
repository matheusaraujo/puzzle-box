#!/bin/bash

ebc_ensure_input_file_exists() {
    local dir=$(ebc_directory)
    if [ ! -f "$dir/data/input.part1.txt" ]; then
        retrieve_seed
        fetch_input_notes
        retrieve_aes_keys
        decode_notes
    fi
}

retrieve_seed() {
    response=$(curl -s -X GET \
        -H "Cookie: everybody-codes=$(cat .ebc.session.cookie)" \
        "https://everybody.codes/api/user/me")

    seed=$(echo "$response" | jq -r '.seed // empty')

    if [ -z "$seed" ] || [ "$seed" == "null" ]; then
        print_line "❌ Error: Could not retrieve seed. Check your .ebc.session.cookie file or network."
        print_line "Response was: $response"
        print_line 1
    fi
}

fetch_input_notes() {
    input_notes_url="https://everybody.codes/assets/$year/$((10#$day))/input/$seed.json"

    response=$(curl -s -X GET \
        -H "Cookie: everybody-codes=$(cat .ebc.session.cookie)" \
        "$input_notes_url")

    if ! echo "$response" | jq -e . &> /dev/null; then
        echo "❌ Error: Failed to fetch valid notes. URL might be incorrect or event/quest does not exist."
        echo "Response was: $response"
        exit 1
    fi

    encoded_note_1=$(echo "$response" | jq -r '."1" // empty')
    encoded_note_2=$(echo "$response" | jq -r '."2" // empty')
    encoded_note_3=$(echo "$response" | jq -r '."3" // empty')
}

retrieve_aes_keys() {
    aes_keys_url="https://everybody.codes/api/event/$year/quest/$((10#$day))"

    response=$(curl -s -X GET \
        -H "Cookie: everybody-codes=$(cat .ebc.session.cookie)" \
        "$aes_keys_url")

    if ! echo "$response" | jq -e . &> /dev/null; then
        echo "❌ Error: Failed to fetch valid keys. Check your .ebc.session.cookie file or if you solved the quest."
        exit 1
    fi

    aes_key_1=$(echo "$response" | jq -r '."key1" // empty')
    aes_key_2=$(echo "$response" | jq -r '."key2" // empty')
    aes_key_3=$(echo "$response" | jq -r '."key3" // empty')

    try_to_extract_answer_from_aes_keys_result $response
}

try_to_extract_answer_from_aes_keys_result() {
    local dir=$(ebc_directory)

    local response="$1"
    local answers_found=0

    local answer1=$(echo "$response" | jq -r '.answer1 // empty')
    if [ -n "$answer1" ]; then
        touch "$dir/data/output.part1.txt"
        echo "$answer1" > "$dir/data/output.part1.txt"
        answers_found=1
    fi

    local answer2=$(echo "$response" | jq -r '.answer2 // empty')
    if [ -n "$answer2" ]; then
        touch "$dir/data/output.part2.txt"
        echo "$answer2" > "$dir/data/output.part2.txt"
        answers_found=1
    fi

    local answer3=$(echo "$response" | jq -r '.answer3 // empty')
    if [ -n "$answer3" ]; then
        touch "$dir/data/output.part3.txt"
        echo "$answer3" > "$dir/data/output.part3.txt"
        answers_found=1
    fi
}


decrypt_note() {
    local note="$1"
    local key_str="$2"
    local part_num="$3"

    local filename="input.part${part_num}.txt"

    if [ -z "$note" ] || [ -z "$key_str" ]; then
        echo "Part $part_num: Skipping decryption (Note or Key is empty/not available)." >&2
        return 1
    fi

    key_hex=$(echo -n "$key_str" | xxd -p | tr -d '\n')

    iv_raw=$(echo -n "$key_str" | head -c 16)
    iv_hex=$(echo -n "$iv_raw" | xxd -p | tr -d '\n')

    decrypted_text=$(echo -n "$note" | xxd -r -p | openssl enc -aes-256-cbc -d \
        -K "$key_hex" \
        -iv "$iv_hex" \
        2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$decrypted_text" ]; then
        echo "❌ Part $part_num Decryption Failed. Check key/note values." >&2
        return 1
    fi

    echo "$decrypted_text"
    return 0
}

decode_notes() {
    local dir=$(ebc_directory)
    touch $dir/data/input.part1.txt
    if ! decrypt_note "$encoded_note_1" "$aes_key_1" "1" > "$dir/data/input.part1.txt"; then
        echo "⚠️ Part 1 failed to decrypt or save."
        rm $dir/data/input.part1.txt
    fi

    touch $dir/data/input.part2.txt
    if ! decrypt_note "$encoded_note_2" "$aes_key_2" "2" > "$dir/data/input.part2.txt"; then
        echo "⚠️ Part 2 failed to decrypt or save."
        rm $dir/data/input.part2.txt
    fi

    touch $dir/data/input.part3.txt
    if ! decrypt_note "$encoded_note_3" "$aes_key_3" "3" > "$dir/data/input.part3.txt"; then
        echo "⚠️ Part 3 failed to decrypt or save."
        rm $dir/data/input.part3.txt
    fi
}