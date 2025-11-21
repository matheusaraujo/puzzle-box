#!/bin/bash

aoc_create() {
    ext=${languages_extensions[$lang]}
    aoc="advent-of-code"
    mkdir -p $aoc/$year/day$day/data
    if [ -e $aoc/$year/day$day/part1.$ext ] || [ -e $aoc/$year/day$day/part2.$ext ]; then
        print_error "Error: part1.$ext or part2.$ext already exists in $aoc/$year/day$day"
        exit 1
    fi
    cp -r $ROOT/langs/$lang/template/part1.$ext $aoc/$year/day$day
    cp -r $ROOT/langs/$lang/template/part2.$ext $aoc/$year/day$day
    print_success "$aoc/$year/day$day created using $lang! ${GREEN}✔${NC}"
    print_success "Great coding! 💻"
}