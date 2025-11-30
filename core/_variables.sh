#/bin/bash

declare -a available_challenges=()
declare -a ignore_files=(".pb-env" "**/data/")

declare -a available_languages=()
declare -A languages_extensions=()
declare -A languages_aliases=()