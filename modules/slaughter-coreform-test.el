;;; slaughter-coreform-test.el --- A sub-package with tools for testing Coreform software.
;;; Summary: Tools for running tests within the emacs comiliation buffer.
(require 'slaughter-coreform-build)

;;; Code:
(defun coreform-test--get-names-f ()
  "COREFORM-TEST: return a list of tests."
  (directory-files (coreform--get-binary-dir-f) nil "Test_.*"))

(defun coreform-test--single-exe-f (test-name)
  "COREFORM-TEST: run an individual test"
  (let ((default-directory (coreform--get-binary-dir-f)))
    (message "COREFORM-TEST: %s" (expand-file-name default-directory test-name))
    (compile (format "./%s" test-name))))

(defun coreform-test-ctest-f (&optional regex)
  "COREFORM-TEST: run ctest with optional regex"
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
    (completing-read "Select test: " (coreform-test--get-names-f))))  
  (coreform-test--ctest-f test-name)
  (coreform-buffer-compilation))

(provide 'slaughter-coreform-test)
