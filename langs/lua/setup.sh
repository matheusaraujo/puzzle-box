#!/bin/bash

sudo apt-get update
sudo apt-get install -y lua5.4 luarocks unzip

echo "export PATH=\$PATH:/usr/bin/lua5.4" >> /home/vscode/.bashrc

sudo luarocks install luacheck

STY_VERSION="v2.0.2"
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
    PLATFORM="linux-x86_64"
elif [ "$ARCH" = "aarch64" ]; then
    PLATFORM="linux-aarch64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Downloading StyLua for $ARCH..."
curl -LO "https://github.com/JohnnyMorganz/StyLua/releases/download/${STY_VERSION}/stylua-${PLATFORM}.zip"

unzip "stylua-${PLATFORM}.zip"
sudo mv stylua /usr/local/bin/

rm "stylua-${PLATFORM}.zip"

echo "Lua setup complete!"