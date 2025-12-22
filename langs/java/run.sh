#/usr/bash

dir=$1
part=$2
input_file=$3

java -cp "$dir:$ROOT/langs/java" main $dir $part < "$input_file"
rm -rf "$dir"/"$part".class