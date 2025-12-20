#!/bin/bash

update_pb_env() {
    local key="$1"
    local value="$2"

    if [[ ! -f .pb-env ]]; then
        echo "$key=$value" >> .pb-env
    else
        if grep -q "^$key=" .pb-env; then
            sed -i "/^$key=/c\\$key=$value" .pb-env
        else
            echo "$key=$value" >> .pb-env
        fi
    fi
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        if [[ " ${!challenges_aliases[@]} " =~ " $1 " ]]; then
            challenge="${challenges_aliases[$1]}"
            update_pb_env "challenge" "$challenge"
        # elif [[ $1 =~ ^[0-9]{4}$ ]]; then
        elif [[ -n "$challenge" && -n "${challenge_event_regex[$challenge]}" && $1 =~ ${challenge_event_regex[$challenge]} ]]; then
            event="$1"
            update_pb_env "event" "$event"
        elif [[ $1 =~ ^([1-9]|0[0-9]|1[0-9]|2[0-5])$  ]]; then
            arg=$(echo "$1" | sed 's/^0*//')
            puzzle=$(printf "%02d" "$arg")
            update_pb_env "puzzle" "$puzzle"
        elif [[ $1 == "part1" || $1 == "part2" || $1 == "part3" ]]; then
            part="$1"
        elif [[ " ${!languages_aliases[@]} " =~ " $1 " ]]; then
            lang="${languages_aliases[$1]}"
        elif [[ $1 == "--watch" || $1 == "-w" ]]; then
            watch_mode="true"
        else
            print_line "Unknown option: $1"
            exit 1
        fi
        shift
    done

    if [[ -z "$challenge" && -z "$event" && -z "$puzzle" && -f ".pb-env" ]]; then
        source .pb-env
    fi
}

load_env_from_file() {
    local file="${1:-.pb-env}"
    if [[ -f "$file" ]]; then
        while IFS='=' read -r key value; do
            case "$key" in
                challenge) challenge="$value" ;;
                event) event="$value" ;;
                puzzle) puzzle="$value" ;;
            esac
        done < "$file"
    fi
}