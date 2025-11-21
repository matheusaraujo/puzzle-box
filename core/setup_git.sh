#!/bin/bash

COMMIT_MSG_SCRIPT="$ROOT/.githooks/commit-msg.sh"
GIT_HOOKS_DIR=".git/hooks"
COMMIT_MSG_HOOK_NAME="commit-msg"

pb_setup_git() {
    print_success "Installing Git hooks..."

    if [ ! -f "$COMMIT_MSG_SCRIPT" ]; then
        print_error "${RED}[ERROR] Commit-msg script not found.${NC}"
        exit 1
    fi

    cp "$COMMIT_MSG_SCRIPT" "$GIT_HOOKS_DIR/$COMMIT_MSG_HOOK_NAME"
    chmod +x "$GIT_HOOKS_DIR/$COMMIT_MSG_HOOK_NAME"
    print_success "${GREEN}Git hooks installed successfully.${NC}"

    for file in "${ignore_files[@]}"; do
        [ ! -f "$file" ] && touch "$file"
    done

    [ ! -f ".gitignore" ] && touch ".gitignore"

    for file in "${ignore_files[@]}"; do
        if ! grep -qxF "$file" ".gitignore"; then
            echo "$file" >> ".gitignore"
            print_success "${GREEN}Added $file to .gitignore"
        fi
    done
}
