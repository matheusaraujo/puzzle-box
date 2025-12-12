#!/bin/bash

TARGET_HOME="/home/vscode"
DENO_INSTALL="$TARGET_HOME/.deno"
DENO_BIN="$DENO_INSTALL/bin"

mkdir -p $DENO_BIN
curl -fsSL https://deno.land/install.sh | DENO_INSTALL="$DENO_INSTALL" sh
chown -R vscode:vscode $DENO_INSTALL

echo "export DENO_INSTALL=\"$DENO_INSTALL\"" >> $TARGET_HOME/.bashrc
echo "export PATH=\"$DENO_BIN:\$PATH\"" >> $TARGET_HOME/.bashrc

chown vscode:vscode $TARGET_HOME/.bashrc