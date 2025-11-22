#/bin/bash

dir=$1
year=$2
day=$3
part=$4
input_file=$5

$ROOT/langs/perl/main.pl $dir $year $day $part < $input_file
