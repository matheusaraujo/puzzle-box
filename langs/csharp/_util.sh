#!/bin/bash

available_languages+=("csharp")

languages_extensions["csharp"]="cs"

languages_aliases["csharp"]="csharp"
languages_aliases["cs"]="csharp"
languages_aliases["c#"]="csharp"

ignore_files+=("**/bin/" "**/obj/" "check.csproj" "Program.cs")