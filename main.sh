#!/bin/bash

export ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $ROOT/core/_utils.sh
source $ROOT/core/_variables.sh

source $ROOT/challenges/challenges.sh
source $ROOT/langs/langs.sh

source $ROOT/core/add_session_cookie.sh
source $ROOT/core/check.sh
source $ROOT/core/clean.sh
source $ROOT/core/commit.sh
source $ROOT/core/create.sh
source $ROOT/core/finish.sh
source $ROOT/core/format.sh
source $ROOT/core/generate_input.sh
source $ROOT/core/help.sh
source $ROOT/core/lang_stats.sh
source $ROOT/core/parse_args.sh
source $ROOT/core/progress.sh
source $ROOT/core/run.sh
source $ROOT/core/setup_repository.sh
source $ROOT/core/validate.sh
source $ROOT/core/version.sh

# COMMAND: help: Show help message
help() {
    pb_help
}

# COMMAND: setup-repository: Configure git hooks, .gitignore and README
setup_repository() {
    pb_setup_repository
}

# COMMAND: add-session-cookie: Add session cookie to files
add_session_cookie() {
    pb_add_session_cookie
}

# COMMAND: create: Create a new solution for the given challenge, event, puzzle, and lang
create() {
    pb_create
}

# COMMAND: generate-input: Generate sample input for given event, puzzle, and part
generate_input() {
    pb_generate_input
}

# COMMAND: run: Execute the solution for given challenge, event and puzzle
run() {
    pb_run
}

# COMMAND: run-event: Execute all solutions for given challenge/event
run_event() {
    pb_run_event
}

# COMMAND: run-challenge: Execute all solutions for given challenge
run_challenge() {
    pb_run_challenge
}

# COMMAND: run-all: Execute all solutions in all challenge
run_all() {
    pb_run_all
}

# COMMAND: format: Format the puzzle
format() {
    pb_format
}

# COMMAND: format-event: Run format for all solutions in given challenge/event
format_event() {
    pb_format_event
}

# COMMAND: format-challenge: Run format for all solutions in the current challenge
format_challenge() {
    pb_format_challenge
}

# COMMAND: format-all: Run format for all solutions in all challenges
format_all() {
    pb_format_all
}

# COMMAND: check: Run checks for puzzle
check() {
    pb_check
}

# COMMAND: check-event: Run checks for all solutions in given challenge/event
check_event() {
    pb_check_event
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

# COMMAND: finish: Check if problem is solved and create a README file on respective directory
finish() {
    pb_finish
}

# COMMAND: progress: Update progress in README
progress() {
    pb_progress
}

# COMMAND: lang-stats: Update the language stats session in README
langs_stats() {
    pb_lang_stats
}

# COMMAND: commit: Validate everything, update README and commit for current puzzle
commit() {
    pb_commit
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
        parse_args "$@"
        case "$cmd" in
            help) help ;;
            setup-repository) setup_repository ;;
            add-session-cookie) add_session_cookie ;;
            create) create ;;
            run) run ;;
            run-event) run_event ;;
            run-challenge) run_challenge ;;
            run-all) run_all ;;
            format) format ;;
            format-event) format_event ;;
            format-challenge) format_challenge ;;
            format-all) format_all ;;
            check) check ;;
            check-event) check_event ;;
            check-challenge) check_challenge ;;
            check-all) check_all ;;
            commit) commit ;;
            generate-input) generate_input ;;
            finish) finish ;;
            progress) progress ;;
            lang-stats) langs_stats ;;
            version) version ;;
            clean) clean ;;
            *) print_line "${RED}[ERROR] Unknown command: $cmd${NC}"; help ;;
        esac
    fi
}

main "$@"
