#!/bin/bash

trap "tput reset; tput cnorm; exit" 2
clear
tput civis

cols=$(tput cols)
rows=$(tput lines)

# Messages shown in "boot sequence" style
lines=(
  "[ OK ] Warming up CPUs... (they're still sleepy)"
  "[ OK ] Fetching fresh coffee... spill probability: HIGH"
  "[ OK ] Plugging in headphones... left side mysteriously louder"
  "[ OK ] Closing 42 unnecessary browser tabs..."
  "[ OK ] Arming puzzle-solving neural circuits..."
  "[ OK ] Threatening the compiler to behave..."
  "[ OK ] Calibrating brain-to-keyboard latency..."
  "[ OK ] Loading puzzle-box core modules..."
  "[ OK ] Verifying challenge providers..."
)

# Print each boot-line with slight delay
tput setaf 46
for l in "${lines[@]}"; do
    echo "$l"
    sleep 0.15
done

sleep 0.2

# Banner
banner=(
"______              _       ______            "
"| ___ \            | |      | ___ \           "
"| |_/ /   _ _______| | ___  | |_/ / _____  __ "
"|  __/ | | |_  /_  / |/ _ \ | ___ \/ _ \ \/ / "
"| |  | |_| |/ / / /| |  __/ | |_/ / (_) >  <\ "
"\_|   \__,_/___/___|_|\___| \____/ \___/_/\_\ "
)

# Center banner
start_row=$((rows/2 - ${#banner[@]}/2))
for line in "${banner[@]}"; do
    col=$(( (cols - ${#line}) / 2 ))
    tput cup $start_row $col
    tput setaf 40; tput bold
    echo "$line"
    ((start_row++))
    sleep 0.06
done

# Subtitle typing effect
subtitle="Enjoy your coding!!!"
sub_col=$(( (cols - ${#subtitle}) / 2 ))

tput setaf 82; tput bold
tput cup $((start_row+1)) $sub_col

for ((i=1; i<=${#subtitle}; i++)); do
    echo -n "${subtitle:0:i}"
    sleep 0.03
    tput cup $((start_row+1)) $sub_col
done

tput sgr0; tput cnorm
echo
