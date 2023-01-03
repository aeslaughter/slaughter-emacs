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

;; function and default for the root coreform directory
(setq coreform-root-default (concat (getenv "HOME") "/cf/master/cf"))
(defun coreform-get-root-dir ()
  "Coreform: check for a 'build' file in the version control root or use '~/cf/master/cf'."
  (if (file-exists-p (concat (vc-root-dir) "/build"))
      (vc-root-dir)
    coreform-root-default))

;; locate the build directory
(defun coreform-get-build-dir ()
  "Coreform: return the build directory."
  (defvar-local build-dir (cond ((string-equal "darwin" (symbol-name system-type)) "build_mac64")
                                ((string-equal "windows-nt" (symbol-name system-type)) "build_win64")
                                (t "build_lin64")))
  (concat (coreform-get-root-dir)  "/../" build-dir))

;; build state make
(defun coreform-build (build-type)
  "Coreform: run 'build stage make'."
  (let ((default-directory (coreform-get-root-dir)))
    (defvar-local build-command (format "./build stage make build-type=%s" (symbol-name build-type)))
    (message build-command)
    (compile build-command)))

;; ninja only build
(defun coreform-ninja (build-type)
  "Coreform: run ninja"
  (defvar ninja-command (cond ((eq build-type 'debug) "ninja -f build-Debug.ninja")
                              ((eq build-type 'release) "ninja -f build-Release.ninja")
                              (t "ninja -f build.ninja")))
  (let ((default-directory (coreform-get-build-dir)))
    (message ninja-command)
    (compile ninja-command)))

(defun coreform-build-debug ()
  "Coreform: configure and compile in debug mode."
  (interactive)
  (coreform-build 'debug))

(defun coreform-build-release ()
  "Coreform: configure and compile in release mode."
  (interactive)
  (coreform-build 'release))

(defun coreform-ninja-debug ()
  "Coreform: execute ninja debug mode."
  (interactive)
  (coreform-ninja 'debug))

(defun coreform-ninja-release ()
  "Coreform: execute ninja release mode."
  (interactive)
  (coreform-ninja 'release))

;; Create coreform map with prefix C-f
(define-prefix-command 'coreform-map)
(global-set-key "\C-f" 'coreform-map)

(define-key coreform-map "d" 'coreform-ninja-debug)
(define-key coreform-map "r" 'coreform-ninja-release)
(define-key coreform-map "\C-d" 'coreform-build-debug)
(define-key coreform-map "\C-r" 'coreform-build-release)
