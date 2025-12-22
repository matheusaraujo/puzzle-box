#!/bin/bash

dir=$1
part=$2
input_file=$3

csproj="$ROOT/langs/csharp/pb.csproj"

dotnet run --project $csproj --no-restore --no-build $dir $part < "$input_file"
