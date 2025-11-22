#!/bin/bash

YEARS=$(seq -w 2015 2025)
DAYS=$(seq -w 1 25)
export ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $ROOT/core/_utils.sh

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
source $ROOT/core/extract_answers.sh
source $ROOT/core/run.sh
source $ROOT/core/setup_git.sh
source $ROOT/core/validate.sh
source $ROOT/core/version.sh

# COMMAND: help: Show help message
help() {
    aoc_help
}

# COMMAND: setup_git: Configure git hooks and .gitignore
setup_git() {
    pb_setup_git
}

# COMMAND: create: Create a new solution for the given challenge, year, day, and lang
create() {
    pb_create
}

# COMMAND: run: Execute the solution for given year and day
run() {
    pb_run
}

# COMMAND: generate-input: Generate sample input for given year, day, and part
generate_input() {
    aoc_generate_input
}

# COMMAND: run-all: Execute all solutions for all years and days
run_all() {
    for year in $YEARS; do
        for day in $DAYS; do
            if [ -d "$year/day$day" ]; then
                echo "----------------------------------------------------------------------"
                echo -e "${GREEN}Running $year day $day...${NC}"
                run || {
                    echo -e "${RED}[ERROR] Test failed for $year day $day.${NC}"
                    exit 1
                }
            fi
        done
    done
}

# COMMAND: run-year: Execute all solutions for given year
run_year() {
    validate_year
    for day in $DAYS; do
        if [ -d "$year/day$day" ]; then
            echo "----------------------------------------------------------------------"
            echo -e "${GREEN}Running $year day $day...${NC}"
            run || {
                echo -e "${RED}[ERROR] Test failed for $year day $day.${NC}"
                exit 1
            }
        fi
    done
}

# COMMAND: format: Format for given year and day
format() {
    pb_format
}

# COMMAND: check: Run checks for given year and day
check() {
    pb_check
}

# COMMAND: version: Show versions of all tools
version() {
    pb_version
}

# COMMAND: check-all: Run validations for all solutions
check_all() {
    for year in $YEARS; do
        for day in $DAYS; do
            if [ -d "$year/day$day" ]; then
                echo "----------------------------------------------------------------------"
                echo -e "${GREEN}Running validation for $year day $day...${NC}"
                check || {
                    echo -e "${RED}[ERROR] Validation failed for $year day $day.${NC}"
                    exit 1
                }
            fi
        done
    done
}

# COMMAND: check-year: Run validations for all solutions in given year
check_year() {
    validate_year
    for day in $DAYS; do
        if [ -d "$year/day$day" ]; then
            echo "----------------------------------------------------------------------"
            echo -e "${GREEN}Running validation for $year day $day...${NC}"
            check || {
                echo -e "${RED}[ERROR] Validation failed for $year day $day.${NC}"
                exit 1
            }
        fi
    done
}

# COMMAND: extract-answers: Fetch puzzle text for given year and day
extract_answers() {
    aoc_puzzle_text
}

# COMMAND: progress: Update progress in README
progress() {
    aoc_progress
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
            setup_git) setup_git ;;
            create) create ;;
            run) run ;;
            run-all) run_all ;;
            run-year) run_year ;;
            format) format ;;
            check) check ;;
            check-all) check_all ;;
            check-year) check_year ;;
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
