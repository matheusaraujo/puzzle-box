#/bin/bash

pb_generate_input() {
    validate_challenge
    validate_event
    ${challenge}_validate_directory
    validate_part

    local dir="$(${challenge}_directory)"
    local title="$(${challenge}_problem_title)"

    letter=$(ls $dir/data/input.$part.*.txt 2>/dev/null | wc -l | awk '{printf "%c", 97 + $1}')

    print_line "input(Ctrl+D to finish):"
    input=$(cat)

    mkdir -p $dir/data
    echo "$input" > $dir/data/input.$part.$letter.txt

    print_line "\noutput:"
    read output

    echo "$output" > $dir/data/output.$part.$letter.txt

}
