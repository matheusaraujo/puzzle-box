#!/bin/bash

pb_finish() {
  validate_challenge
  validate_year
  validate_day

  ${challenge}_finish

  # curl -s -b session=$(cat session.cookie) https://adventofcode.com/$year/day/$(echo $day | sed 's/^0*//') -o $year/day$day/_readme1.html

  # if ! grep -q '<p class="day-success">Both parts of this puzzle are complete!' $year/day$day/_readme1.html; then
  #   print_line "puzzle is not complete yet"
  #   exit 1
  # fi

  # answers=($(grep -oP '<p>Your puzzle answer was <code>\K[^<]+' $year/day$day/_readme1.html))
  # if [ ${#answers[@]} -eq 0 ]; then
  #   print_line "Error: Unable to extract any answers"
  #   exit 1
  # fi
  # mkdir -p $year/day$day/data
  # printf "%s" "${answers[0]}" > $year/day$day/data/output.part1.txt
  # if [ ${#answers[@]} -eq 2 ]; then
  #   printf "%s" "${answers[1]}" > $year/day$day/data/output.part2.txt
  # fi

  # if [ "${_AOC_FORCE_PUZZLE_TEXT:-}" == "true" ]; then
  #   echo -e "\e[31m⚠️ DISCLAIMER ⚠️\e[0m"
  #   echo -e "\e[33m⚠️ WARNING: According to the Advent of Code FAQ (https://adventofcode.com/2024/about#faq_copying), this action is discouraged.\e[0m"
  #   echo -e "\e[33m⚠️ Proceed at your own risk.\e[0m"

  #   sed -n '/<main>/,/<\/main>/p' $year/day$day/_readme1.html > $year/day$day/_readme2.html
  #   sed '/<p class="day-success">Both parts of this puzzle are complete!/q' $year/day$day/_readme2.html | sed '$a</main>' > $year/day$day/_readme3.html
  #   pandoc --from=html --to=markdown --output=$year/day$day/README.md $year/day$day/_readme3.html
  #   sed -i 's/::: {role="main"}//g' $year/day$day/README.md
  #   sed -i 's/{#part2}//g' $year/day$day/README.md
  #   sed -i '${/^:::$/d}' $year/day$day/README.md
  #   print_line "readme $year/day$day generated ${CHECK_SUCCESS}"
  # else
  #   sed -n '/<main>/,/<\/main>/p' $year/day$day/_readme1.html > $year/day$day/_readme2.html
  #   extracted_title=$(sed -n 's/.*<h2>\(.*\)<\/h2>.*/\1/p' $year/day$day/_readme2.html)
  #   readme_content="# Advent of Code - ${year} Day ${day}\n\n${extracted_title}\n\nhttps://adventofcode.com/${year}/day/$(echo $day | sed 's/^0*//')"
  #   echo -e "$readme_content" > $year/day$day/README.md
  #   print_line "readme $year/day$day generated ${CHECK_SUCCESS}"
  # fi

  # rm $year/day$day/_readme*.html
}
