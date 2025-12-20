#!/bin/bash

dir=$1
event=$2
puzzle=$3
part=$4
input_file=$5

workspace_dir="$(pwd)/$dir"
lua_dir="$ROOT/langs/lua"

ln -sf "$workspace_dir/part1.lua" "$lua_dir/part1.lua"
ln -sf "$workspace_dir/part2.lua" "$lua_dir/part2.lua"
ln -sf "$workspace_dir/part3.lua" "$lua_dir/part3.lua"

if [ -f "$workspace_dir/helpers.lua" ]; then
    ln -sf "$workspace_dir/helpers.lua" "$lua_dir/helpers.lua"
fi

export LUA_PATH="$lua_dir/?.lua;;"
lua "$lua_dir/main.lua" "$dir" "$event" "$puzzle" "$part" < "$input_file"