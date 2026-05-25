#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/helper.bash"

setup() {
    pb_workdir
}

@test "setup_git_ignore adds entries and is idempotent" {
    setup_git_ignore >/dev/null
    setup_git_ignore >/dev/null

    [ "$(grep -c '^\.pb-env$' .gitignore)" -eq 1 ]
    grep -qx '\.aoc.session.cookie' .gitignore
    grep -qx '\.ecd.session.cookie' .gitignore
}

@test "setup_root_readme_file creates a README with progress markers" {
    setup_root_readme_file false

    [ -f README.md ]
    grep -qF '<!-- progress-begin -->' README.md
    grep -qF '<!-- progress-end -->' README.md
    grep -qF '<!-- langs-stats-begin -->' README.md
    grep -qF '<!-- langs-stats-end -->' README.md
}

@test "setup_root_readme_file appends missing markers to an existing README" {
    printf '# My Solutions\n' > README.md
    setup_root_readme_file false

    grep -qF '# My Solutions' README.md
    grep -qF '<!-- progress-begin -->' README.md
    grep -qF '<!-- langs-stats-end -->' README.md
}
