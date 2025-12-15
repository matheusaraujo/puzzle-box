#/bin/bash

declare -a available_challenges=()
declare -A challenges_titles=()
declare -A challenges_aliases=()
declare -a ignore_files=(".pb-env" "**/data/")

declare -a available_languages=()
declare -A languages_extensions=()
declare -A languages_aliases=()

declare -A challenge_event_regex=()
