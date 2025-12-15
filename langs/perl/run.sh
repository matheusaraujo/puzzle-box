#/bin/bash

dir=$1
event=$2
day=$3
part=$4
input_file=$5

$ROOT/langs/perl/main.pl $dir $event $puzzle $part < $input_file
