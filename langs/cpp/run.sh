#!/bin/bash

dir=$1
part=$2
input_file=$3

workspace_dir="$(pwd)/$dir"
cpp_dir="$ROOT/langs/cpp"

compile_files=("$cpp_dir/main.cpp")

ln -sf "$workspace_dir/part1.cpp" "$cpp_dir/part1.cpp"
compile_files+=("$cpp_dir/part1.cpp")

if [ -f "$workspace_dir/part2.cpp" ]; then
  ln -sf "$workspace_dir/part2.cpp" "$cpp_dir/part2.cpp"
else
  ln -sf "$cpp_dir/template/part2.cpp" "$cpp_dir/part2.cpp"
fi
compile_files+=("$cpp_dir/part2.cpp")

if [ -f "$workspace_dir/part3.cpp" ]; then
  ln -sf "$workspace_dir/part3.cpp" "$cpp_dir/part3.cpp"
else
  ln -sf "$cpp_dir/template/part3.cpp" "$cpp_dir/part3.cpp"
fi
compile_files+=("$cpp_dir/part3.cpp")

if [ -f "$workspace_dir/helpers.cpp" ]; then
  ln -sf "$workspace_dir/helpers.cpp" "$cpp_dir/helpers.cpp"
  compile_files+=("$cpp_dir/helpers.cpp")
fi

g++ -O3 "${compile_files[@]}" -o "$cpp_dir/solution"
"$cpp_dir/solution" "$dir" "$part" < "$input_file"

# echo "xpto"