#!/bin/bash

sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:dotnet/backports
sudo apt-get update
sudo apt-get install -y dotnet-sdk-9.0

export TMPDIR=/home/vscode/tmp
export DOTNET_CLI_HOME=/home/vscode/.dotnet
export NUGET_PACKAGES=/home/vscode/.nuget/packages
export NUGET_HTTP_CACHE_PATH=/home/vscode/.nuget/http-cache
export PATH=/home/vscode/.dotnet/tools:/home/vscode/.dotnet:$PATH

mkdir -p "$TMPDIR" \
         "$DOTNET_CLI_HOME/tools" \
         "$NUGET_PACKAGES" \
         "$NUGET_HTTP_CACHE_PATH"
