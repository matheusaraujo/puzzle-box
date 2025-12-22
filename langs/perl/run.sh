#/bin/bash

dir=$1
part=$2
input_file=$3

$ROOT/langs/perl/main.pl $dir $part < $input_file
