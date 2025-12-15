#!/bin/bash

dir=$1
event=$2
day=$3
part=$4
input_file=$5

workspace_dir="$(pwd)/$dir"
go_dir="$ROOT/langs/go"

ln -sf $workspace_dir/part1.go $go_dir/part1.go
part1_arg="$go_dir/part1.go"

part2_arg=""
if [ -f "$workspace_dir/part2.go" ]; then
  ln -sf $workspace_dir/part2.go $go_dir/part2.go
  part2_arg="$go_dir/part2.go"
else
  ln -sf $go_dir/template/part2.go $go_dir/part2.go
  part2_arg="$go_dir/part2.go"
fi

part3_arg=""
if [ -f "$workspace_dir/part3.go" ]; then
  ln -sf $workspace_dir/part3.go $go_dir/part3.go
  part3_arg="$go_dir/part3.go"
else
  ln -sf $go_dir/template/part3.go $go_dir/part3.go
  part3_arg="$go_dir/part3.go"
fi

helpers_arg=""
if [ -f "$workspace_dir/helpers.go" ]; then
  ln -sf $workspace_dir/helpers.go $go_dir/helpers.go
  helpers_arg="$go_dir/helpers.go"
fi

go run \
  $part1_arg \
  $part2_arg \
  $part3_arg \
  $helpers_arg \
  $go_dir/main.go \
  $dir $event $puzzle $part < "$input_file"
