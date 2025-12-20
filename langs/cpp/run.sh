#!/bin/bash

dir=$1
event=$2
puzzle=$3
part=$4
input_file=$5

workspace_dir="$(pwd)/$dir"
cpp_dir="$ROOT/langs/cpp"

# Prepare compilation list starting with main
compile_files=("$cpp_dir/main.cpp")

# Handle Part 1
ln -sf "$workspace_dir/part1.cpp" "$cpp_dir/part1.cpp"
compile_files+=("$cpp_dir/part1.cpp")

# Handle Part 2
if [ -f "$workspace_dir/part2.cpp" ]; then
  ln -sf "$workspace_dir/part2.cpp" "$cpp_dir/part2.cpp"
else
  ln -sf "$cpp_dir/template/part2.cpp" "$cpp_dir/part2.cpp"
fi
compile_files+=("$cpp_dir/part2.cpp")

# Handle Part 3
if [ -f "$workspace_dir/part3.cpp" ]; then
  ln -sf "$workspace_dir/part3.cpp" "$cpp_dir/part3.cpp"
else
  ln -sf "$cpp_dir/template/part3.cpp" "$cpp_dir/part3.cpp"
fi
compile_files+=("$cpp_dir/part3.cpp")

# Handle Helpers
if [ -f "$workspace_dir/helpers.cpp" ]; then
  ln -sf "$workspace_dir/helpers.cpp" "$cpp_dir/helpers.cpp"
  compile_files+=("$cpp_dir/helpers.cpp")
fi

# Compile and Run
g++ -O3 "${compile_files[@]}" -o "$cpp_dir/solution"
"$cpp_dir/solution" "$dir" "$event" "$puzzle" "$part" < "$input_file"