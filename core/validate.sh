#!/bin/bash

validate_challenge() {
    if [ -z "$challenge" ]; then
        print_line "${RED}[CHALLENGE] Challenge must be defined.${NC}"
        exit 1
    else
        local valid_challenge=false
        for valid in "${available_challenges[@]}"; do
            if [[ "$challenge" == "$valid" ]]; then
                valid_challenge=true
                break
            fi
        done

        if [ "$valid_challenge" == false ]; then
            print_line "${RED}[CHALLENGE] Challenge must be one of: ${available_challenges[*]}.${NC}"
            exit 1
        fi
    fi
}

validate_event() {
    if [ -z "$event" ]; then
        print_line "${RED}[ERROR] Event must be defined.${NC}"
        exit 1
    fi
}

validate_day() {
    if [ -z "$day" ]; then
        print_line "${RED}[ERROR] Day must be defined.${NC}"
        exit 1
    fi
}

validate_lang() {
    if [ -z "$lang" ]; then
        print_line "${RED}[ERROR] Language must be defined.${NC}"
        exit 1
    else
        local valid_lang=false
        for valid in "${available_languages[@]}"; do
            if [[ "$lang" == "$valid" ]]; then
                valid_lang=true
                break
            fi
        done

        if [ "$valid_lang" == false ]; then
            print_line "${RED}[ERROR] Language must be one of: ${available_languages[*]}.${NC}"
            exit 1
        fi
    fi
}

validate_part() {
    ${challenge}_validate_part
}
