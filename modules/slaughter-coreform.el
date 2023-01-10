;;; slaughter-coreform --- Utilities for building and running Coreform tools
;;; Commentary:
(setq debug-on-error t)

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

(setq coreform-webpack-mode 'development)
(setq coreform-webpack-watch t)

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
    (setq build-command (format "./build stage make --build-type=%s" (symbol-name build-type)))
    (message "CORFORM::BUILD %s" build-command)
    (compile build-command)))

;; ninja only build
(defun coreform-ninja (build-type)
  "Coreform: run ninja"
  (setq ninja-command (cond ((eq build-type 'debug) "ninja -f build-Debug.ninja")
                            ((eq build-type 'release) "ninja -f build-Release.ninja")
                            (t "ninja -f build.ninja")))
  (let ((default-directory (coreform-get-build-dir)))
    (message "COREFORM::NINJA %s" ninja-command)
    (compile ninja-command)))

;; run a single test
(defun coreform-test-single (test-name build-type)
  "Coreform: run an individual test"
  (let ((default-directory (coreform-get-binary-dir build-type)))
    (message "COREFORM::TEST %s" (expand-file-name default-directory test-name))
    (compile (format "./%s" test-name))))

;; run a single test
(defun coreform-run-ctest (build-type &optional regex)
  "Coreform: run ctest with optional regex"
  (if regex
      (setq ctest-command (format "ctest -C %s --tests-regex %s" build-type regex))
    (setq ctest-command (format "ctest -C %s" build-type)))
  (let ((default-directory (coreform-get-build-dir)))
    (message "COREFORM::CTEST %s" ctest-command)
    (compile ctest-command)))

;; build stage test
(defun coreform-build-test (build-type)
  "Coreform: run 'build stage test'."
  (let ((default-directory (coreform-get-root-dir)))
    (setq test-command (format "./build stage test --skip-cmake --skip-build --build-type=%s" (symbol-name build-type)))
    (message "CORFORM::TEST %s" test-command)
    (compile test-command)))

(setq debug-on-error t)

;; webpack
(defun coreform-webpack (location process-name)
  "Coreform: run 'webpack' (from the root) from the given location" 
  (setq-local webpack-command (format "%s/node_modules/.bin/webpack" (coreform-get-root-dir)))
  (let ((default-directory (concat (coreform-get-root-dir) location)))
    (setq buffer-name (format "*%s*" process-name))
    (unless (get-buffer buffer-name)
      (with-current-buffer buffer-name
        (erase-buffer)))
    (start-process process-name buffer-name webpack-command (format "--mode=%s" (symbol-name coreform-webpack-mode)) (if coreform-webpack-watch "--watch" "--no-watch"))
    (coreform-select-buffer-window buffer-name)))
    ;; (with-current-buffer buffer-name
    ;;   (setq-local major-mode 'compilation-mode)
    ;;   (setq-local buffer-read-only t))))

(defun coreform-webpack-compile (location process-name)
  "Coreform: run 'webpack' in a process, prompting to kill if it is already running"
  (interactive)
  (when (equal (process-status process-name) 'run)
    (y-or-n-p (format "A webpack process '%s' is running, kill it? " process-name)
              (delete-process process-name) nil))
  (unless (equal (process-status process-name) 'run)
    (coreform-webpack location process-name)))

(defun coreform-webpack-flex ()
  "Coreform: run webpack in the flex directory"
  (interactive)
  (coreform-webpack-compile "/flex" "coreform-webpack-flex"))

(defun coreform-set-webpack-mode-development ()
  "Coreform: set the webpack mode to development"
  (interactive)
  (setq coreform-webpack-mode 'development))

(defun coreform-set-webpack-mode-release ()
  "Coreform: set the webpack mode to development"
  (interactive)
  (setq coreform-webpack-mode 'release))

(defun coreform-webpack-toggle-watch ()
  "Coreform: toggle the webpack watch flag"
  (interactive)
  (setq coreform-webpack-watch (not coreform-webpack-watch))
  (message "COREFORM:: watch mode is %s" (if coreform-webpack-watch "on" "off")))

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

(defun coreform-select-buffer-window (buffer-name)
  "Coreform: switch to the window with a buffer of the given name"
  (let ((the-buffer (get-buffer-window buffer-name)))
    (if (not (equal the-buffer nil))
        (select-window the-buffer))))

(defun coreform-test (test-name)
  "Coreform: execute a single test directly as a command."
  (interactive
   (list
    (completing-read "Select test: " (coreform-get-test-names coreform-default-build))))
  (coreform-test-single test-name coreform-default-build)
  (coreform-buffer-compilation))

(defun coreform-ctest (test-name)
  (interactive
   (list
    (complemting-read "Select test: " (coreform-get-test-names coreform-default-build))))  
  (coreform-run-ctest coreform-default-build test-name)
  (coreform-buffer-compilation))

(defun coreform-buffer-compilation ()
  "Coreform: switch to *compilation* buffer."
  (interactive)
  (coreform-select-buffer-window "*compiliation*"))

(defun coreform-kill-webpack ()
  "Coreform: kill running webpack process"
  (interactive))

(defun coreform-help ()
  "Coreform: show all coreform-... commands"
  (interactive)
  (minibuffer-with-setup-hook
      (lambda ()
        (insert "coreform-"))
    (call-interactively #'execute-extended-command)))


;; Create coreform map with prefix C-f
(define-prefix-command 'coreform-map)
(global-set-key "\C-f" 'coreform-map)

(define-key coreform-map "h" 'coreform-help)
(define-key coreform-map "t" 'coreform-test)
(define-key coreform-map "c" 'coreform-ctest)
(define-key coreform-map "d" 'coreform-ninja-debug)
(define-key coreform-map "r" 'coreform-ninja-release)
(define-key coreform-map "\C-d" 'coreform-build-debug)
(define-key coreform-map "\C-r" 'coreform-build-release)
(define-key coreform-map "b"  'coreform-buffer-compilation)
