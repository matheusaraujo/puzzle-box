# Shared bats helper for puzzle-box tests.
#
# This file is pulled in with `load helper` at the top of each .bats file,
# which sources it at the test file's global scope. That matters: the
# registries use `declare -A`/`declare -a`, and `declare` only creates global
# arrays when run outside a function (exactly how main.sh sources them in
# production). Sourcing from inside a function would make them disappear.

export ROOT
ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"

source "$ROOT/core/_utils.sh"
source "$ROOT/core/_variables.sh"
source "$ROOT/challenges/challenges.sh"
source "$ROOT/langs/langs.sh"
source "$ROOT/core/parse_args.sh"
source "$ROOT/core/validate.sh"
source "$ROOT/core/version.sh"
source "$ROOT/core/setup_repository.sh"
source "$ROOT/core/run.sh"
source "$ROOT/core/generate_input.sh"

# Move into the per-test temp dir so helpers that write .pb-env / README.md /
# solution folders never touch the working tree. Call from each test's setup().
pb_workdir() {
    cd "$BATS_TEST_TMPDIR" || return 1
}
