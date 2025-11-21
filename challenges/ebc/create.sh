#!/bin/bash

ebc_create() {
    ext=${languages_extensions[$lang]}
    ec="everybody.codes"
    mkdir -p $ec/$year/quest$day/data
    if [ -e $ec/$year/quest$day/part1.$ext ] || [ -e $ec/$year/quest$day/part2.$ext ] || [ -e $ec/$year/quest$day/part3.$ext ] ; then
        print_error "Error: part1.$ext or part2.$ext already exists in $aoc/$year/day$day"
        exit 1
    fi
    cp -r $ROOT/langs/$lang/template/part1.$ext $ec/$year/quest$day
    cp -r $ROOT/langs/$lang/template/part2.$ext $ec/$year/quest$day
    cp -r $ROOT/langs/$lang/template/part3.$ext $ec/$year/quest$day
    print_success "$ec/$year/quest$day created using $lang! ${GREEN}✔${NC}"
    print_success "Great coding! 💻"
}