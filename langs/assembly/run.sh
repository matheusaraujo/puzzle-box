#!/bin/bash

dir=$1
part=$2
input_file=$3

workspace_dir="$(pwd)/$dir"
asm_dir="$ROOT/langs/assembly"

source_file="$part.asm"
target_file="$asm_dir/solve.asm"

ln -sf "$workspace_dir/$source_file" "$target_file"

asm_file_to_compile="$target_file"
object_file="$asm_dir/solve.o"
executable="$asm_dir/solve"

nasm -f elf64 "$asm_file_to_compile" -o "$object_file"
if [ $? -ne 0 ]; then
    echo "Assembly failed."
    exit 1
fi

x86_64-linux-gnu-ld "$object_file" -o "$executable"
if [ $? -ne 0 ]; then
    echo "Linking failed."
    exit 1
fi

cat "$input_file" | "$executable"

rm "$object_file" "$executable"