#!/bin/bash

COMMIT_MSG_SCRIPT="$ROOT/.githooks/commit-msg.sh"
GIT_HOOKS_DIR=".git/hooks"
COMMIT_MSG_HOOK_NAME="commit-msg"

pb_setup_repository() {
    setup_git_hook
    setup_git_ignore
    setup_root_readme_file
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
    print_line "Setting up README.md ..."

    local README_FILE="README.md"
    local MARKERS=(
        "<!-- progress-begin -->"
        "<!-- progress-end -->"
    )

    if [ ! -f "$README_FILE" ]; then
        touch "$README_FILE"
    fi

    for MARKER in "${MARKERS[@]}"; do
        if ! grep -qF "$MARKER" "$README_FILE"; then
            echo "$MARKER" >> "$README_FILE"
        fi
    done

    print_line "${GREEN}README.md setup done.${NC}"
}
