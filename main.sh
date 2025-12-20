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
    if [[ "$exec_all" == "true" ]]; then
        pb_run_all
    elif [[ "$exec_challenge" == "true" ]]; then
        pb_run_challenge
    elif [[ "$exec_event" == "true" ]]; then
        pb_run_event
    else
        pb_run
    fi
}

# COMMAND: format: Format the puzzle
format() {
    if [[ "$exec_all" == "true" ]]; then
        pb_format_all
    elif [[ "$exec_challenge" == "true" ]]; then
        pb_format_challenge
    elif [[ "$exec_event" == "true" ]]; then
        pb_format_event
    else
        pb_format
    fi
}

# COMMAND: check: Run checks for puzzle
check() {
    if [[ "$exec_all" == "true" ]]; then
        pb_check_all
    elif [[ "$exec_challenge" == "true" ]]; then
        pb_check_challenge
    elif [[ "$exec_event" == "true" ]]; then
        pb_check_event
    else
        pb_check
    fi
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
            format) format ;;
            check) check ;;
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
