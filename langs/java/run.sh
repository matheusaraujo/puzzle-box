#/usr/bash

dir=$1
year=$2
day=$3
part=$4
input_file=$5

java -cp "$dir:$ROOT/langs/java" main $year $day $part < "$input_file"