#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

files=("part1.js" "part2.js" "part3.js" "helpers.js")

npm --silent --prefix $ROOT/langs/javascript/ install $ROOT/langs/javascript/

for file in "${files[@]}"; do
    if [ -f "$dir/$file" ]; then
        if prettier "$dir/$file" --write --log-level silent; then
            print_success "prettier $dir/$file \033[32m✔\033[0m"
        else
            exit 1
        fi
    fi
done
