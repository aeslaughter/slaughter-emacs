;;; slaughter-coreform --- Utilities for building and running Coreform tools
;;; Commentary:

;; Enable color for *compilation* buffer
(slaughter-package-install 'ansi-color)
;;emacs 28.1 ;;(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

;; a few default variables (TODO: add function for changing these)
(setq coreform-default-root (concat (getenv "HOME") "/cf/master/cf"))
(setq coreform-default-build 'debug)

;; function and default for the root coreform directory
(defun coreform-get-root-dir ()
  "Coreform: check for a 'build' file in the version control root or use '~/cf/master/cf'."
  (if (file-exists-p (concat (vc-root-dir) "/build"))
      (vc-root-dir)
    coreform-default-root))

;; locate the build directory
(defun coreform-get-build-dir ()
  "Coreform: return the build directory."
  (defvar-local build-dir (cond ((string-equal "darwin" (symbol-name system-type)) "build_mac64")
                                ((string-equal "windows-nt" (symbol-name system-type)) "build_win64")
                                (t "build_lin64")))
  (expand-file-name (concat (coreform-get-root-dir)  "/../" build-dir)))

;; locate the compiled location
(defun coreform-get-binary-dir (build-type)
  "Coreform: return the binary directory."
  (defvar-local binary-dir (cond ((eq build-type 'debug) "/bin/Debug")
                                 (t "/bin/Release")))
  (concat (coreform-get-build-dir) binary-dir))

;; get list of available tests
(defun coreform-get-test-names (build-type)
  "Coreform: return a list of tests."
  (directory-files (coreform-get-binary-dir build-type) nil "Test_.*"))

;; build stage make
(defun coreform-build (build-type)
  "Coreform: run 'build stage make'."
  (let ((default-directory (coreform-get-root-dir)))
    (defvar-local build-command (format "./build stage make build-type=%s" (symbol-name build-type)))
    (message "CORFORM::BUILD %s" build-command)
    (compile build-command)))

;; ninja only build
(defun coreform-ninja (build-type)
  "Coreform: run ninja"
  (defvar-local ninja-command (cond ((eq build-type 'debug) "ninja -f build-Debug.ninja")
                              ((eq build-type 'release) "ninja -f build-Release.ninja")
                              (t "ninja -f build.ninja")))
  (let ((default-directory (coreform-get-build-dir)))
    (message "COREFORM::NINJA %s" ninja-command)
    (compile ninja-command)))

;; run a single test
(defun coreform-test-single (test-name &optional build-type)
  "Coreform: run an individual test"
  (unless build-type (setq build-type coreform-default-build))
  (let ((default-directory (coreform-get-binary-dir build-type)))
    (message "COREFORM::TEST %s" (expand-file-name default-directory test-name))
    (compile (format "./%s" test-name))))

(defun coreform-build-debug ()
  "Coreform: configure and compile in debug mode."
  (interactive)
  (setq coreform-default-build 'debug)
  (coreform-build 'debug)
  (coreform-buffer-compilation))

(defun coreform-build-release ()
  "Coreform: configure and compile in release mode."
  (interactive)
  (setq coreform-default-build 'release)
  (coreform-build 'release)
  (coreform-buffer-compilation))

(defun coreform-ninja-debug ()
  "Coreform: execute ninja debug mode."
  (interactive)
  (setq coreform-default-build 'debug)
  (coreform-ninja 'debug)
  (coreform-buffer-compilation))

(defun coreform-ninja-release ()
  "Coreform: execute ninja release mode."
  (interactive)
  (setq coreform-default-build 'release)
  (coreform-ninja 'release)
  (coreform-buffer-compilation))

(defun coreform-test (test-name)
  "Coreform: execute a single test directly as a command."
  (interactive
   (list
    (completing-read "Select test: " (coreform-get-test-names coreform-default-build))))
  (coreform-test-single test-name coreform-default-build)
  (coreform-buffer-compilation))

(defun coreform-buffer-compilation ()
  "Coreform: switch to *compilation* buffer."
  (interactive)
  (let ((the-buffer (get-buffer-window "*compilation*")))
    (if (not (equal the-buffer nil))
        (select-window the-buffer))))

;; Create coreform map with prefix C-f
(define-prefix-command 'coreform-map)
(global-set-key "\C-f" 'coreform-map)

(define-key coreform-map "t" 'coreform-test)
(define-key coreform-map "d" 'coreform-ninja-debug)
(define-key coreform-map "r" 'coreform-ninja-release)
(define-key coreform-map "\C-d" 'coreform-build-debug)
(define-key coreform-map "\C-r" 'coreform-build-release)
(define-key coreform-map "c"  'coreform-buffer-compilation)
