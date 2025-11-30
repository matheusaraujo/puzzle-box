#!/bin/bash

export ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $ROOT/core/_utils.sh
source $ROOT/core/_variables.sh

source $ROOT/challenges/challenges.sh
source $ROOT/langs/langs.sh

source $ROOT/core/check.sh
source $ROOT/core/clean.sh
source $ROOT/core/commit.sh
source $ROOT/core/create.sh
source $ROOT/core/format.sh
source $ROOT/core/generate_input.sh
source $ROOT/core/help.sh
source $ROOT/core/langs_stats.sh
source $ROOT/core/parse_args.sh
source $ROOT/core/progress.sh
source $ROOT/core/readme.sh
source $ROOT/core/extract_answers.sh
source $ROOT/core/run.sh
source $ROOT/core/setup_repository.sh
source $ROOT/core/validate.sh
source $ROOT/core/version.sh

# COMMAND: help: Show help message
help() {
    aoc_help
}

# COMMAND: setup-repository: Configure git hooks, .gitignore and README
setup_repository() {
    pb_setup_repository
}

# COMMAND: create: Create a new solution for the given challenge, year, day, and lang
create() {
    pb_create
}

# COMMAND: generate-input: Generate sample input for given year, day, and part
generate_input() {
    aoc_generate_input
}

# COMMAND: run: Execute the solution for given challenge, year and day
run() {
    pb_run
}

# COMMAND: run-year: Execute all solutions for given challenge/year
run_year() {
    pb_run_year
}

# COMMAND: run-challenge: Execute all solutions for given challenge
run_challenge() {
    pb_run_challenge
}

# COMMAND: run-all: Execute all solutions in all challenge
run_all() {
    pb_run_all
}

# COMMAND: format: Format for given challenge, year and day
format() {
    pb_format
}

# COMMAND: format-year: Run format for all solutions in given challenge/year
format_year() {
    pb_format_year
}

# COMMAND: format-challenge: Run format for all solutions in the current challenge
format_challenge() {
    pb_format_challenge
}

# COMMAND: format-all: Run format for all solutions in all challenges
format_all() {
    pb_format_all
}

# COMMAND: check: Run checks for given challenge, year and day
check() {
    pb_check
}

# COMMAND: check-year: Run checks for all solutions in given challenge/year
check_year() {
    pb_check_year
}

# COMMAND: check-challenge: Run checks for all solutions in the current challenge
check_challenge() {
    pb_check_challenge
}

# COMMAND: check-all: Run checks for all solutions in all challenge
check_all() {
    pb_check_all
}

# COMMAND: version: Show versions of all tools
version() {
    pb_version
}

# COMMAND: extract-answers: Fetch puzzle text for given year and day
extract_answers() {
    aoc_puzzle_text
}

# COMMAND: progress: Update progress in README
progress() {
    pb_progress
}

# COMMAND: lang-stats: Update the language stats session in README
langs_stats() {
    aoc_lang_stats
}

# COMMAND: commit: Validate and commit for given year and day
commit() {
    if ! validate_year_day; then
        return 1
    fi
    format
    check
    run
    extract_answers
    progress
    langs_stats
    aoc_commit
}

# COMMAND: clean: Clean temporary files
clean() {
    pb_clean
}

# Parse the command and run the corresponding function
main() {
    if [ $# -eq 0 ]; then
        help
    else
        cmd="$1"
        shift
        if [ "$cmd" == "create" ]; then
            infer_year_day
        fi
        parse_args "$@"
        case "$cmd" in
            help) help ;;
            setup-repository) setup_repository ;;
            create) create ;;
            run) run ;;
            run-year) run_year ;;
            run-challenge) run_challenge ;;
            run-all) run_all ;;
            format) format ;;
            format-year) format_year ;;
            format-challenge) format_challenge ;;
            format-all) format_all ;;
            check) check ;;
            check-year) check_year ;;
            check-challenge) check_challenge ;;
            check-all) check_all ;;
            commit) commit ;;
            generate-input) generate_input ;;
            tree) lib/tree.sh ;;
            extract-answers) extract_answers ;;
            progress) progress ;;
            lang-stats) langs_stats ;;
            version) version ;;
            clean) clean ;;
            *) print_line "${RED}[ERROR] Unknown command: $cmd${NC}"; help ;;
        esac
    fi
}

main "$@"
