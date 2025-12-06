(in-package :cl-user)

;; --- Path Resolution and Conditional Load ---
(defun resolve-part-path (filename)
  "Resolves the full path of a file relative to the directory of the currently loading script."
  (let* ((script-dir (make-pathname :directory (pathname-directory (truename *load-pathname*)))))
    (merge-pathnames filename script-dir)))

(defun load-if-exists (filename)
  "Loads a file if it exists at the resolved path."
  (let ((filepath (resolve-part-path filename)))
    (when (probe-file filepath)
      (load filepath))))

;; --- Load Dependencies in Order ---
;; 1. Load helpers first to define the :AOC-HELPERS package.
(load-if-exists "helpers.lisp")

;; 2. Load the part files which depend on helpers.
(load-if-exists "part1.lisp")
(load-if-exists "part2.lisp")
(load-if-exists "part3.lisp")


;; --- I/O Helper ---
(defun read-puzzle-input ()
  "Reads all input from STDIN, chunking it into a single string."
  (with-open-stream (stream *standard-input*)
    (let ((buffer (make-string 4096)))
      (with-output-to-string (s)
        (loop
           (let ((count (read-sequence buffer stream :start 0 :end 4096)))
             (write-sequence buffer s :start 0 :end count)
             (unless (= count 4096) (return))))))))

;; --- Main Dispatch Logic ---
(defun main ()
  ;; Read command-line arguments (passed by run.sh)
  (let* ((cmd-args sb-ext:*posix-argv*)
         (part (elt cmd-args 1))
         (puzzle-input-string (read-puzzle-input))
         (puzzle-input (list puzzle-input-string))
         (result nil))

    ;; Dispatch based on the part string.
    (cond ((string= part "part1")
           (setf result (part1 puzzle-input)))

          ((string= part "part2")
           ;; Check if part2 function exists before calling
           (if (fboundp 'part2)
               (setf result (part2 puzzle-input))
               (setf result "Part 2 function undefined.")))

          ((string= part "part3")
           ;; Check if part3 function exists before calling
           (if (fboundp 'part3)
               (setf result (part3 puzzle-input))
               (setf result "Part 3 function undefined.")))

          (t
           (setf result (format nil "Unknown part: ~A" part))))

    ;; Print the result
    (format t "~A~%" result)))

;; Execute the main function when the script runs
(main)