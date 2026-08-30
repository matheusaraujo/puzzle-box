#!/bin/bash

# These registries are populated by the challenge/language _util.sh files and
# read across the whole tool. Declared with -g so they are global regardless of
# whether this file is sourced at top level (production) or from within a
# function (e.g. test harnesses).
declare -ga available_challenges=()
declare -gA challenges_titles=()
declare -gA challenges_aliases=()
declare -ga ignore_files=(".pb-env" "**/data/")

declare -ga available_languages=()
declare -gA languages_extensions=()
declare -gA languages_aliases=()

declare -gA challenge_event_regex=()
