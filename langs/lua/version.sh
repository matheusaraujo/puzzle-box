#!/bin/bash

echo "[lua]"
lua -v

echo "[luacheck]"
luacheck -v

echo "[stylua]"
stylua --version