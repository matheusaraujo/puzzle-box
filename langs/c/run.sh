#!/bin/bash

dir=$1
part=$2
input_file=$3

$ROOT/langs/c/run $dir $part < "$input_file"

