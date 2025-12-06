#!/bin/bash

dir=$1
year=$2
day=$3
part=$4
input_file=$5

workspace_dir="$(pwd)/$dir"
lisp_dir="$ROOT/langs/lisp"

ln -sf "$workspace_dir/part1.lisp" "$lisp_dir/part1.lisp"
if [ -f "$workspace_dir/part2.lisp" ]; then
    ln -sf "$workspace_dir/part2.lisp" "$lisp_dir/part2.lisp"
else
    ln -sf "$lisp_dir/template/part2.lisp" "$lisp_dir/part2.lisp"
fi

if [ -f "$workspace_dir/part3.lisp" ]; then
    ln -sf "$workspace_dir/part3.lisp" "$lisp_dir/part3.lisp"
else
    ln -sf "$lisp_dir/template/part3.lisp" "$lisp_dir/part3.lisp"
fi

if [ -f "$workspace_dir/helpers.lisp" ]; then
    ln -sf "$workspace_dir/helpers.lisp" "$lisp_dir/helpers.lisp"
else
    ln -sf "$lisp_dir/template/helpers.lisp" "$lisp_dir/helpers.lisp"
fi

sbcl --noinform --script "$lisp_dir/main.lisp" "$part" < "$input_file"