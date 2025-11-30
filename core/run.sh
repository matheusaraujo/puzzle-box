#!/bin/bash

pb_run_year() {
    validate_challenge
    validate_year

    for day in $POTENTIAL_DAYS; do
        local dir="$(${challenge}_directory)"
        if [ -d "$dir" ]; then
            pb_run || {
                echo -e "${RED}[ERROR] Run failed for $challenge: $year - $day${NC}"
                exit 1
            }
            print_line "----------------------------------------------------------------------"
        fi
    done
}

pb_run_challenge() {
    validate_challenge

    for year in $POTENTIAL_YEARS; do
        pb_run_year
    done
}

pb_run_all() {
    for challenge in "${available_challenges[@]}"; do
        pb_run_challenge
    done
}

pb_run() {
    validate_challenge
    validate_year
    validate_day

    ${challenge}_validate_directory
    ${challenge}_ensure_input_file_exists
    ${challenge}_try_to_extract_data_from_website

    if [ "$watch_mode" == "true" ]; then
        run_watch_mode
    else
        run_full_puzzle
    fi
}

run_watch_mode() {
    local watch_dir="$(${challenge}_directory)"
    print_line "${GREEN}Running $watch_dir in watch mode...\nPress Ctrl+C to stop.${NC}"
    (run_full_puzzle) || true

    inotifywait -m -r -e close_write,create,delete "$watch_dir" --exclude '\.pyc(\..*)?$|\.bak$' 2>/dev/null |
    while read -r directory events filename; do
        clear
        (run_full_puzzle) || true
        print_line "\n${GREEN}Running $watch_dir in watch mode...\nPress Ctrl+C to stop.${NC}"
    done
}

run_full_puzzle() {
    if [[ -n "$lang" ]]; then
        process_language_puzzle "$lang"
        exit 0
    else
        for ((i=0; i<${#available_languages[@]}; i++)); do
            l="${available_languages[$i]}"
            process_language_puzzle "$l"
        done
    fi
}

process_language_puzzle() {
    local lang=$1
    local ext=${languages_extensions[$lang]}
    local dir="$(${challenge}_directory)"
    local title="$(${challenge}_problem_title)"

    if [ -f "$dir/part1.$ext" ]; then
        print_line "run($lang): $title"

        if [ -f "$ROOT/langs/$lang/build.sh" ]; then
            $ROOT/langs/$lang/build.sh "$dir"

            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi

        process_language_part "$dir" "$lang" "part1"
        [ -f "$dir/part2.$ext" ] && process_language_part "$dir" "$lang" "part2"
        [ -f "$dir/part3.$ext" ] && process_language_part "$dir" "$lang" "part3"
    fi
}

process_language_part() {
    local dir=$1
    local lang=$2
    local part=$3

    for input_file in "$dir/data/input.$part".*.txt; do
        [ -f "$input_file" ] || continue

        local output_file="${input_file/input/output}"
        validate_output_file "$output_file"
        execute_lang_run_sh "$dir" "$lang" "$year" "$day" "$part" "$input_file" "$output_file"
    done

    local input_file="$(${challenge}_input_file $part)"
    if [ -f "$input_file" ]; then
        local output_file="$dir/data/output.$part.txt"
        if [ -f "$output_file" ]; then
            execute_lang_run_sh "$dir" "$lang" "$year" "$day" "$part" $input_file $output_file
        else
            execute_lang_run_sh "$dir" "$lang" "$year" "$day" "$part" $input_file
        fi
    fi
}

execute_lang_run_sh() {
    local dir=$1
    local lang=$2
    local year=$3
    local day=$4
    local part=$5
    local input_file=$6
    local output_file=$7

    local start_time=$(date +%s%N)

    /usr/bin/time -f "Max Memory: %M KB\nCPU Usage: %P" \
        -o /tmp/resource_usage.txt -- \
        $ROOT/langs/$lang/run.sh "$dir" "$year" "$day" "$part" "$input_file" > /tmp/script_output.txt 2>&1
    local script_exit_code=$?
    local end_time=$(date +%s%N)

    local elapsed_time=$((end_time - start_time))
    local elapsed=""
    local elapsed_ms=$(echo "scale=3; $elapsed_time / 1000000" | bc)
    local elapsed_s=$(echo "scale=3; $elapsed_time / 1000000000" | bc)
    local elapsed_min=$(echo "scale=3; $elapsed_time / 60000000000" | bc)

    if (( $(echo "$elapsed_time < 1000000000" | bc -l) )); then
        elapsed="${elapsed_ms}ms"
    elif (( $(echo "$elapsed_time < 60000000000" | bc -l) )); then
        elapsed="${elapsed_s}s"
    else
        elapsed="${elapsed_min}min" # TODO: fix this
    fi

    if [ $script_exit_code -ne 0 ]; then
        echo "Script failed to execute." >&2
        cat /tmp/script_output.txt >&2
        exit 1
    fi

    local script_output=$(cat /tmp/script_output.txt | tail -1)
    local resource_usage=$(cat /tmp/resource_usage.txt)
    local max_memory_kb=$(echo "$resource_usage" | grep "Max Memory" | awk '{print $3}')
    local cpu_usage=$(echo "$resource_usage" | grep "CPU Usage" | awk '{print $3}')

    local max_memory=""
    if [ "$max_memory_kb" -ge 1048576 ]; then
        max_memory=$(echo "scale=2; $max_memory_kb / 1048576" | bc)GB
    elif [ "$max_memory_kb" -ge 1024 ]; then
        max_memory=$(echo "scale=2; $max_memory_kb / 1024" | bc)MB
    else
        max_memory="${max_memory_kb}KB"
    fi

    local result_symbol=""
    local input_label=$(generate_input_label "$input_file")

    if [ -n "$output_file" ]; then
        validate_output_file "$output_file"
        local expected_output=$(cat "$output_file")

        if [ "$script_output" != "$expected_output" ]; then
            print_line "${PURPLE}$part$input_label: \033[0m\033[32m$script_output${GRAY_ITALIC} (execution time: ${elapsed}, memory: ${max_memory}, cpu: ${cpu_usage})\033[91m ✘ Expected: $expected_output \033[0m"
            if [ $(wc -l < /tmp/script_output.txt) -gt 1 ]; then
                echo -e "$(head -n -1 /tmp/script_output.txt)"
            fi
            exit 1
        fi
        result_symbol="${CHECK_SUCCESS}"
    fi

    print_line "${PURPLE}$part$input_label: \033[0m\033[32m$script_output${GRAY_ITALIC} (execution time: ${elapsed}, memory: ${max_memory}, cpu: ${cpu_usage}) $result_symbol\033[0m"

    if [ $(wc -l < /tmp/script_output.txt) -gt 1 ]; then
        echo -e "$(head -n -1 /tmp/script_output.txt)"
    fi
}

validate_output_file() {
    local output_file=$1
    if [ ! -f "$output_file" ]; then
        print_line "Error: Output file $output_file does not exist."
        exit 1
    fi
}

generate_input_label() {
    local file_name
    file_name=$(basename "$1")

    if [[ "$file_name" == "input.txt" ]] || [[ "$file_name" =~ ^input\.part[0-9]+\.txt$ ]]; then
        echo ""
        return
    fi

    IFS='.' read -ra parts <<< "$file_name"

    echo "(${parts[-2]})"
}
