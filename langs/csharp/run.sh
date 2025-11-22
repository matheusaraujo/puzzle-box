#!/bin/bash

year=$2
day=$3
part=$4
input_file=$5

csproj="$ROOT/langs/csharp/pb.csproj"

dotnet run --project $csproj --no-restore --no-build $year $day $part < "$input_file"
