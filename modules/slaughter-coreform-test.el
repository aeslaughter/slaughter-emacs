;;; slaughter-coreform-test.el --- A sub-package with tools for testing Coreform software.
;;; Summary: Tools for running tests within the emacs comiliation buffer.
(require 'slaughter-coreform-build)

;;; Code:
(defvar coreform-test--output-on-error-flag nil
  "COREFORM-TEST: flag for setting --output-on-error command line argument for ctest function.")

(defvar coreform-test--keep-artifacts-flag nil
  "COREFORM-TEST: flag for setting KEEP_SIM_TEST_ARTIFACTS.")

(defun coreform-test--get-names-f ()
  "COREFORM-TEST: return a list of tests."
  (directory-files (coreform--get-binary-dir-f) nil "Test_.*"))

(defun coreform-test--single-exe-f (test-name)
  "COREFORM-TEST: run an individual test"
  (let ((default-directory (coreform--get-binary-dir-f))
        (test-command (list (if coreform-test--keep-artifacts-flag "KEEP_SIM_TEST_ARTIFACTS=1" nil)
                            (format "./%s" test-name))))

    (let ((the-command (string-join (remove nil test-command) " ")))
      (message "COREFORM-TEST: %s" the-command)
      (compile the-command))))
   
;; (message "COREFORM-TEST: %s" (expand-file-name default-directory test-name))
;; (compile (format "./%s" test-name))))

(defun coreform-test--ctest-f (&optional regex)
  "COREFORM-TEST: run ctest function directly."
  (let ((default-directory (coreform-build--get-dir-f))
        (ctest-command (list (if coreform-test--keep-artifacts-flag "KEEP_SIM_TEST_ARTIFACTS=1" nil)
                             "ctest"
                             "-j 32"
                             "-T Test"
                             (format "-C %s" (symbol-name coreform-build--type-v))
                             "-E \"Daily|Benchmark|Problem|machine_learning-python\""
                             "-LE \"LICENSE_TESTING|FLAKY_PSCULPT|RESEARCH|REGRESSION\""
                             (format "--test-dir %s" (coreform-build--get-dir-f))
                             (if coreform-test--output-on-error-flag "--output-on-error" nil)
                             (if regex (format "--tests-regex %s" regex) nil))))
    (let ((the-command (string-join (remove nil ctest-command) " ")))
      (message "COREFORM-TEST: %s" the-command)
      (compile the-command))))

(defun coreform-test--all (build-type)
  "COREFORM-TEST: run 'build stage test'."
  (interactive)
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

(defun coreform-test-keep-sim-artificats-on ()
  "COREFORM-TEST: enable KEEP_SIM_TEST_ARTIFACTS environment variable."
  (interactive)
  (setq coreform-test--keep-artifacts-flag t))

(defun coreform-test-keep-sim-artificats-off ()
  "COREFORM-TEST: disable KEEP_SIM_TEST_ARTIFACTS environment variable."
  (interactive)
  (setq coreform-test--keep-artifacts-flag f))


(provide 'slaughter-coreform-test)
