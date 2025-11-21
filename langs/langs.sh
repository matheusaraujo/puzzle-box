#!/bin/bash

# Languages
available_languages=(c csharp go java javascript python perl)

declare -A languages_extensions
languages_extensions=(
    ["c"]="c"
    ["csharp"]="cs"
    ["go"]="go"
    ["java"]="java"
    ["javascript"]="js"
    ["perl"]="pl"
    ["python"]="py"
)

declare -A languages_aliases
languages_aliases=(
    ["c"]="c"
    ["clang"]="c"
    ["csharp"]="csharp"
    ["c#"]="csharp"
    ["go"]="go"
    ["golang"]="go"
    ["java"]="java"
    ["js"]="javascript"
    ["javascript"]="javascript"
    ["pl"]="perl"
    ["perl"]="perl"
    ["py"]="python"
    ["python"]="python"
)
