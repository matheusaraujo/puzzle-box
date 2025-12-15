#/usr/bash

dir=$1
event=$2
day=$3
part=$4
input_file=$5

java -cp "$dir:$ROOT/langs/java" main $dir $event $day $part < "$input_file"
rm -rf "$dir"/"$part".class