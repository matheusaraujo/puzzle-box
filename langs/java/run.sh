#/usr/bash

dir=$1
event=$2
puzzle=$3
part=$4
input_file=$5

java -cp "$dir:$ROOT/langs/java" main $dir $event $puzzle $part < "$input_file"
rm -rf "$dir"/"$part".class