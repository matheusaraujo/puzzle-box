#!/bin/bash

year=$1
day=$2
part=$3
input_file=$4

$ROOT/langs/c/run $year $day $part < "$input_file"

