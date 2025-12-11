#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3
debug=0

TS_LANG_ROOT="$ROOT/langs/typescript"

TSCONFIG_ESLINT_PATH="$TS_LANG_ROOT/tsconfig.eslint.tmp.json"
RELATIVE_DIR=$(realpath --relative-to="$TS_LANG_ROOT" "$dir")

files=("part1.ts" "part2.ts" "part3.ts" "helpers.ts")

npm_output=$(npm --silent --prefix "$TS_LANG_ROOT/" install "$TS_LANG_ROOT/" 2>&1)
if [ $? -ne 0 ]; then
    print_line "${PURPLE}npm install${GRAY_ITALIC} typescript/ ${CHECK_ERROR}"
    print_line "$npm_output"
    exit 1
elif [ $debug -eq 1 ]; then
    print_line "${PURPLE}npm install${GRAY_ITALIC} typescript/ ${CHECK_SUCCESS}"
fi


cat > "$TSCONFIG_ESLINT_PATH" << EOF
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "CommonJS",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "skipLibCheck": true,
    "outDir": "./dist",
    "types": ["node"]
  },
  "extends": "./tsconfig.json",
  "include": [
    "${RELATIVE_DIR}/*.ts"
  ]
}
EOF

cleanup() {
    rm -f "$TSCONFIG_ESLINT_PATH"
}
trap cleanup EXIT

for file in "${files[@]}"; do
    path="$dir/$file"
    if [ -f "$path" ]; then
        eslint_output=$(npx eslint "$path" --config "$TS_LANG_ROOT/eslint.config.mjs" 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}eslint${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$eslint_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}eslint${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi

        prettier_output=$(prettier "$path" --check 2>&1)
        if [ $? -ne 0 ]; then
            print_line "${PURPLE}prettier --check${GRAY_ITALIC} $path ${CHECK_ERROR}"
            print_line "$prettier_output"
            exit 1
        elif [ $debug -eq 1 ]; then
            print_line "${PURPLE}prettier --check${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        else
            print_line "${PURPLE}eslint/prettier --check${GRAY_ITALIC} $path ${CHECK_SUCCESS}"
        fi
    fi
done