#!/bin/bash

source $ROOT/core/_utils.sh

dir=$1
event=$2
puzzle=$3
lisp_dir="$ROOT/langs/lisp"

# Define the path for the temporary Lisp formatter script
LISP_FORMATTER_SCRIPT="$lisp_dir/lisp_formatter.lisp"

# --- 1. Create the temporary Lisp formatter script with package stub ---
cat > "$LISP_FORMATTER_SCRIPT" << EOF
(require 'asdf) ; Required for UIOP dependency later in helpers.lisp

;; DEFINE PACKAGE STUB: This allows the Lisp reader to resolve symbols
;; like 'AOC-HELPERS:PARSE-INPUT' when reading part1.lisp/part2.lisp.
(defpackage :aoc-helpers
  (:use :cl :uiop)
  (:export :parse-input))

;; Ensure the stub is registered
(in-package :cl-user)

(defun format-file (file-path)
  "Reads the file at FILE-PATH, pretty-prints its contents, and overwrites the file."
  (let ((data nil))
    (with-open-file (in file-path :direction :input :if-does-not-exist nil)
      (when in
        ;; Read all top-level expressions from the file
        (handler-case
            (loop
              (push (read in) data))
          (end-of-file ()))))

    (when data
      ;; Open file for output and write pretty-printed expressions
      (with-open-file (out file-path :direction :output :if-exists :supersede :if-does-not-exist :create)
        (let ((*print-case* :downcase) ; Common style: ensures symbols are printed lowercase
              (*print-pretty* t)        ; Enables pretty-printing
              (*print-right-margin* 80)) ; Sets a max line width
          ;; Print the expressions in the reverse order they were read (top-level forms)
          (dolist (expr (reverse data))
            (pprint expr out)
            ;; Add an extra newline for separation between top-level forms
            (format out "~%")))))))

;; --- Main Execution ---
(let ((args sb-ext:*posix-argv*))
  ;; The file path is expected as the first argument after the script name (index 1)
  (when (> (length args) 1)
    (format-file (elt args 1))))
EOF


files=("part1.lisp" "part2.lisp" "part3.lisp" "helpers.lisp")

SUCCESS=0

for file in "${files[@]}"; do
    FILE_PATH="$dir/$file"
    if [ -f "$FILE_PATH" ]; then
        # Execute the Lisp formatter script, passing the file path as an argument
        sbcl --noinform --script "$LISP_FORMATTER_SCRIPT" "$FILE_PATH" 2>&1

        if [ $? -ne 0 ]; then
            print_line "${PURPLE}lisp_formatter${GRAY_ITALIC} $dir/$file ${CHECK_ERROR}"
            SUCCESS=1
        else
            print_line "${PURPLE}lisp_formatter${GRAY_ITALIC} $dir/$file ${CHECK_SUCCESS}"
        fi
    fi
done

rm "$LISP_FORMATTER_SCRIPT"

exit $SUCCESS