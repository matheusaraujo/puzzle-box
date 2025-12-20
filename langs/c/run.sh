#!/bin/bash

dir=$1
event=$2
puzzle=$3
part=$4
input_file=$5

$ROOT/langs/c/run $dir $event $puzzle $part < "$input_file"

