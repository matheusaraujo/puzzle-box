#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/helper.bash"

setup() {
    pb_workdir
}

@test "generate_input_label returns empty for real puzzle inputs" {
    [ "$(generate_input_label "advent-of-code/2015/day01/data/input.txt")" = "" ]
    [ "$(generate_input_label "everybody.codes/2024/quest01/data/input.part1.txt")" = "" ]
}

@test "generate_input_label labels sample inputs by their suffix" {
    [ "$(generate_input_label "x/data/input.part1.a.txt")" = "(a)" ]
    [ "$(generate_input_label "x/data/input.part2.b.txt")" = "(b)" ]
}

# Points ROOT at a fake tree with a trivial "fake" language whose runner just
# echoes the input back, so the real timing / comparison logic in
# execute_lang_run_sh can be exercised without any language toolchain. Mutates
# the current shell (ROOT, $R), so it must NOT be called via $(...).
_make_fake_root() {
    R="$BATS_TEST_TMPDIR/root"
    mkdir -p "$R/langs/fake" "$R/sol/data"
    printf '#!/bin/bash\ncat "$3"\n' > "$R/langs/fake/run.sh"
    chmod +x "$R/langs/fake/run.sh"
    printf '42' > "$R/sol/data/input.txt"
    ROOT="$R"
}

@test "execute_lang_run_sh reports success when output matches" {
    command -v /usr/bin/time >/dev/null 2>&1 || skip "/usr/bin/time not available"
    _make_fake_root
    printf '42' > "$R/sol/data/output.part1.txt"
    run execute_lang_run_sh "$R/sol" fake 2015 01 part1 "$R/sol/data/input.txt" "$R/sol/data/output.part1.txt"
    [ "$status" -eq 0 ]
    [[ "$output" == *"part1"* ]]
}

@test "execute_lang_run_sh fails when output does not match" {
    command -v /usr/bin/time >/dev/null 2>&1 || skip "/usr/bin/time not available"
    _make_fake_root
    printf '99' > "$R/sol/data/output.part1.txt"
    run execute_lang_run_sh "$R/sol" fake 2015 01 part1 "$R/sol/data/input.txt" "$R/sol/data/output.part1.txt"
    [ "$status" -eq 1 ]
    [[ "$output" == *"Expected: 99"* ]]
}
