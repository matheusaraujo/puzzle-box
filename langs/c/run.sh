#!/bin/bash

dir=$1
event=$2
day=$3
part=$4
input_file=$5

$ROOT/langs/c/run $dir $event $day $part < "$input_file"

