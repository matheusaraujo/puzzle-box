#!/bin/bash

# --- LISP CODE CHECKING SCRIPT ---

source $ROOT/core/_utils.sh

dir=$1
year=$2
day=$3

TEMP_LISP_SCRIPT="$dir/temp_check.lisp"

# This script loads files using a probe-file check to handle optional files.
cat > "$TEMP_LISP_SCRIPT" << 'EOF'
(in-package :cl-user)

(defun load-if-exists (filename)
  "Loads a file if it exists, relative to the current script's path."
  (let ((filepath (merge-pathnames filename *load-pathname*)))
    (when (probe-file filepath)
      (load filepath))))

;; Handler to suppress warnings (which would otherwise clutter output)
(handler-bind ((warning #'muffle-warning))
  ;; Load files in dependency order: helpers -> parts -> main
  (load-if-exists "helpers.lisp") ; Optional helpers
  (load-if-exists "part1.lisp")   ; Always present
  (load-if-exists "part2.lisp")   ; Optional
  (load-if-exists "part3.lisp")   ; Optional
  (load-if-exists "main.lisp"))   ; Always present entry point

;; Ensure the script exits cleanly with a successful status
(sb-ext:quit :unix-status 0)
EOF
echo "" >> "$TEMP_LISP_SCRIPT"

output=$(sbcl --noinform --script "$TEMP_LISP_SCRIPT" 2>&1)

EXIT_STATUS=$?

rm "$TEMP_LISP_SCRIPT"

if [ $EXIT_STATUS -ne 0 ]; then
    print_line "${PURPLE}sbcl check${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
    echo "$output"
    exit 1
else
    if echo "$output" | grep -q "unhandled condition"; then
        print_line "${PURPLE}sbcl check${GRAY_ITALIC} $dir/ ${CHECK_ERROR}"
        echo "$output"
        exit 1
    else
        print_line "${PURPLE}sbcl check${GRAY_ITALIC} $dir/ ${CHECK_SUCCESS}"
    fi
fi