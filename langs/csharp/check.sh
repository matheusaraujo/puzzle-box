#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
puzzle=$3
debug=0

output=$(dotnet new console -n check -o "$dir" --force --verbosity quiet 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}dotnet new${GRAY_ITALIC} $dir ${CHECK_ERROR}"
    print_line "$output"
    exit 1
elif [ $debug -eq 1 ]; then
    print_line "${PURPLE}dotnet new${GRAY_ITALIC} $dir ${CHECK_SUCCESS}"
fi

output=$(dotnet add "$dir/check.csproj" package Microsoft.CodeAnalysis.NetAnalyzers 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}dotnet add package${GRAY_ITALIC} $dir/check.csproj ${CHECK_ERROR}"
    print_line "$output"
    exit 1
elif [ $debug -eq 1 ]; then
    print_line "${PURPLE}dotnet add package${GRAY_ITALIC} $dir/check.csproj ${CHECK_SUCCESS}"
fi

sed -i '/<\/PropertyGroup>/i \
  <TreatWarningsAsErrors>true</TreatWarningsAsErrors>' "$dir/check.csproj"

if [ $debug -eq 1 ]; then
  print_line "${PURPLE}update csproj${GRAY_ITALIC} $dir/check.csproj ${CHECK_SUCCESS}"
fi

build_output=$(dotnet build "$dir/check.csproj" --verbosity quiet 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}dotnet build${GRAY_ITALIC} $dir/check.csproj ${CHECK_ERROR}"
    print_line "$build_output"
    exit 1
else
    rm -rf "$dir/check.csproj"
    rm -rf "$dir/bin/"
    rm -rf "$dir/obj/"
    rm -rf "$dir/Program.cs"
    print_line "${PURPLE}dotnet build${GRAY_ITALIC} $dir/check.csproj ${CHECK_SUCCESS}"
fi


