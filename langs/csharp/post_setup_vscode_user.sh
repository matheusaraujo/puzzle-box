#!/bin/bash

dotnet tool install -g csharpier

mkdir -p /home/vscode/tmp
export TMPDIR=/home/vscode/tmp
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true