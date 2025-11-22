#!/bin/bash

pb_clean() {
  declare -a patterns=(
    "**/_readme*.html"
    "helpers.sh"
    "*.plist"
    "**/bin"
    "**/obj"
    "**/check.csproj"
    "**/Program.cs"
    "*.class"
    "node_modules"
    "*.pl.bak"
    "*.pl.tdy"
    "*.pl.ERR"
    "**/__pycache__"
  )

  for pattern in "${patterns[@]}"; do
    if [[ "$pattern" == */ ]]; then
      dir_pattern="${pattern%/}"
    else
      dir_pattern="$pattern"
    fi

    # directories
    while IFS= read -r -d '' dir; do
      rm -rf "$dir"
    done < <(find . -type d -path "./$dir_pattern" -prune -print0 2>/dev/null)

    # files
    while IFS= read -r -d '' file; do
      rm -f "$file"
    done < <(find . -type f -path "./$pattern" -print0 2>/dev/null)

  done

  print_line "Cleaning completed ${CHECK_SUCCESS}"
}
