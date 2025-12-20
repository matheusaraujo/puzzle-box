#!/bin/bash

dir="$1"

target_path="$(realpath "$dir")"
base_path="$(realpath "$ROOT/langs/csharp")"
relative_dir="$(realpath --relative-to="$base_path" "$target_path")"

additional_files="$relative_dir/part1.cs"
if [ -f "$relative_dir/part2.cs" ]; then
    additional_files="$additional_files;$relative_dir/part2.cs"
else
    additional_files="$additional_files;template/part2.cs"
fi
if [ -f "$relative_dir/part3.cs" ]; then
    additional_files="$additional_files;$relative_dir/part3.cs"
else
    additional_files="$additional_files;template/part3.cs"
fi
if [ -f "$relative_dir/helpers.cs" ]; then
    additional_files="$additional_files;$relative_dir/helpers.cs"
fi

csproj="$ROOT/langs/csharp/pb.csproj"

dotnet clean "$csproj" --verbosity=quiet > /dev/null 2>&1
if [ $? -ne 0 ]; then
    dotnet clean "$csproj"
    exit 1
fi

dotnet build "$csproj" /p:AdditionalFiles="\"$additional_files\"" --verbosity=quiet > /dev/null 2>&1
if [ $? -ne 0 ]; then
    dotnet build "$csproj" /p:AdditionalFiles="\"$additional_files\"" --verbosity=normal
    exit 1
fi
