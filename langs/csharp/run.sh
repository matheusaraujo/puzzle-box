#!/bin/bash

year=$1
day=$2
part=$3
input_file=$4

csproj="$ROOT/langs/csharp/pb.csproj"

dotnet run --project $csproj --no-restore --no-build $year $day $part < "$input_file"
