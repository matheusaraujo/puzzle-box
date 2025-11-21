#!/bin/bash

ebc_create() {
    local ext=${languages_extensions[$lang]}
    local dir=$(ebc_directory)
    mkdir -p $dir/data
    if [ -e $dir/part1.$ext ] || [ -e $dir/part2.$ext ] || [ -e $dir/part3.$ext ]; then
        print_error "[Everybody.Codes] Error: part1.$ext, part2.$ext or part3.$ext already exists in $aoc/$year/day$day"
        exit 1
    fi
    cp -r $ROOT/langs/$lang/template/part1.$ext $dir
    cp -r $ROOT/langs/$lang/template/part2.$ext $dir
    cp -r $ROOT/langs/$lang/template/part3.$ext $dir
    print_success "[Everybody.Codes] $dir created using $lang! ${GREEN}✔${NC}"
    print_success "Great coding! 💻"
}