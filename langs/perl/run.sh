#/bin/bash

dir=$1
event=$2
puzzle=$3
part=$4
input_file=$5

$ROOT/langs/perl/main.pl $dir $event $puzzle $part < $input_file
