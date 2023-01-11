;;; slaughter-coreform-test.el --- A sub-package with tools for testing Coreform software.
;;; Summary: Tools for running tests within the emacs comiliation buffer.
(require 'slaughter-coreform-build)

;;; Code:
(defvar coreform-test--output-on-error-flag nil
  "COREFORM-TEST: flag for setting --output-on-error command line argument for ctest function.")

(defun coreform-test--get-names-f ()
  "COREFORM-TEST: return a list of tests."
  (directory-files (coreform--get-binary-dir-f) nil "Test_.*"))

(defun coreform-test--single-exe-f (test-name)
  "COREFORM-TEST: run an individual test"
  (let ((default-directory (coreform--get-binary-dir-f)))
    (message "COREFORM-TEST: %s" (expand-file-name default-directory test-name))
    (compile (format "./%s" test-name))))


;; /home/slaughter/cf/master/conda_deps_lin64/bin/ctest -j 64 -T Test -C Release --no-tests=error /home/slaughter/cf/master/cf/cdev_test.xml -E "Daily|Benchmark|Problem|machine_learning-python"  -LE "LICENSE_TESTING|FLAKY_PSCULPT|RESEARCH|REGRESSION" --test-dir /home/slaughter/cf/master/build_lin64
(defun coreform-test--ctest-f (&optional regex)
  "COREFORM-TEST: run ctest function directly."
  (let ((default-directory (coreform-build--get-dir-f))
        (ctest-command (list "ctest"
                             "-j 32"
                             "-T Test"
                             (format "-C %s" (symbol-name coreform-build--type-v))
                             "-E \"Daily|Benchmark|Problem|machine_learning-python\""
                             "-LE \"LICENSE_TESTING|FLAKY_PSCULPT|RESEARCH|REGRESSION\""
                             (format "--test-dir %s" (coreform-build--get-dir-f))
                             (if coreform-test--output-on-error-flag "--output-on-error" "")
                             (if regex (format "--tests-regex %s" regex))))) 
    (message (string-join ctest-command " "))
    (compile (string-join ctest-command " "))))

(defun coreform-test--build-stage-test-f (&optional regex)
  "COREFORM-TEST: run ctest via 'build stage test' with optional regex"
  (let ((default-directory (coreform-build--get-dir-f))
        (ctest-command (if regex
                           (format "ctest -C %s --tests-regex %s" coreform-build--type-v regex)
                         (format "ctest -C %s" coreform-build--type-v))))
    (message "COREFORM-TEST: %s" ctest-command)
    (compile ctest-command)))

(defun coreform-test--all (build-type)
  "COREFORM-TEST: run 'build stage test'."
  (let ((default-directory (coreform-build--get-dir-f))
        (test-command (format "./build stage test --skip-cmake --skip-build --build-type=%s" (symbol-name coreform-build--type-v))))
    (message "CORFORM-TEST: %s" test-command)
    (compile test-command)))

;; Interactive commands:
(defun coreform-test (test-name)
  "COREFORM-TEST: execute a single test directly as a command."
  (interactive
   (list
    (completing-read "Select test: " (coreform-test--get-names-f))))
  (coreform-test--single-exe-f test-name)
  (coreform-buffer-compilation))

(defun coreform-ctest (test-name)
  (interactive
   (list
    (completing-read "Select test: " (coreform-test--get-names-f) nil nil)))  
  (coreform-test--ctest-f test-name)
  (coreform-buffer-compilation))

(provide 'slaughter-coreform-test)
