#!/bin/bash

COMMIT_MSG_SCRIPT="$ROOT/.githooks/commit-msg.sh"
GIT_HOOKS_DIR=".git/hooks"
COMMIT_MSG_HOOK_NAME="commit-msg"

pb_setup_repository() {
    setup_git_hook
    setup_git_ignore
    setup_root_readme_file true
}

setup_git_hook() {
    print_line "Installing Git hooks..."

    if [ ! -f "$COMMIT_MSG_SCRIPT" ]; then
        print_line "${RED}[ERROR] Commit-msg script not found.${NC}"
        exit 1
    fi

    cp "$COMMIT_MSG_SCRIPT" "$GIT_HOOKS_DIR/$COMMIT_MSG_HOOK_NAME"
    chmod +x "$GIT_HOOKS_DIR/$COMMIT_MSG_HOOK_NAME"
    print_line "${GREEN}Git hooks installed successfully.${NC}"
}

setup_git_ignore() {
    print_line "Setting up .gitignore ..."

    [ ! -f ".gitignore" ] && touch ".gitignore"

    for file in "${ignore_files[@]}"; do
        if ! grep -qxF "$file" ".gitignore"; then
            echo "$file" >> ".gitignore"
            print_line "${GREEN}Added $file to .gitignore"
        fi
    done

    print_line "${GREEN}.gitignore setup done.${NC}"
}

setup_root_readme_file() {
    local debug="$1"

    if [[ "$debug" == true ]]; then
        print_line "Setting up README.md ..."
    fi

    local README_FILE="README.md"

    local repo_name
    repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
    [[ -z "$repo_name" ]] && repo_name="Project"

    if [[ ! -f "$README_FILE" ]]; then
        cat > "$README_FILE" <<EOF
# $repo_name
> Using https://github.com/matheusaraujo/puzzle-box

<!-- progress-begin -->
<!-- progress-end -->

<!-- langs-stats-begin -->
<!-- langs-stats-end -->
EOF
    else

        local MARKERS=(
            "<!-- progress-begin -->"
            "<!-- progress-end -->"
            "<!-- langs-stats-begin -->"
            "<!-- langs-stats-end -->"
        )

        for MARKER in "${MARKERS[@]}"; do
            if ! grep -qF "$MARKER" "$README_FILE"; then
                echo "$MARKER" >> "$README_FILE"
            fi
        done
    fi

    if [[ "$debug" == true ]]; then
        print_line "${GREEN}README.md setup done.${NC}"
    fi
}


