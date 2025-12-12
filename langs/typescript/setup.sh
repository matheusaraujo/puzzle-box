#!/bin/bash

TARGET_HOME="/home/vscode"
BUN_INSTALL_DIR="/usr/local/bin"
BUN_HOME_DIR="$TARGET_HOME/.bun"

curl -fsSL https://bun.sh/install | bash

if [ -f "/root/.bun/bin/bun" ]; then
    mv /root/.bun/bin/bun "$BUN_INSTALL_DIR"
    rm -rf /root/.bun
else
    exit 1
fi

mkdir -p "$BUN_HOME_DIR"
chown -R vscode:vscode "$BUN_HOME_DIR"

echo "" >> "$TARGET_HOME/.bashrc"
echo "export BUN_INSTALL=\"$BUN_HOME_DIR\"" >> "$TARGET_HOME/.bashrc"
echo "export PATH=\"$BUN_INSTALL_DIR:\$PATH\"" >> "$TARGET_HOME/.bashrc"
chown vscode:vscode "$TARGET_HOME/.bashrc"

CD_PATH="/usr/local/puzzle-box/langs/typescript"

if [ -d "$CD_PATH" ]; then
    export PATH="$BUN_INSTALL_DIR:$PATH"
    cd "$CD_PATH"

    bun install --loglevel warn
    bun add -d eslint prettier
else
    exit 1
fi