;;; slaughter-coreform --- Utilities for building and running Coreform tools
;;; Commentary:
;;; 

;; Enable color for *compilation* buffer
(slaughter-package-install 'ansi-color)
;;emacs 28.1 ;;(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

(setq coreform-root-default (concat (getenv "HOME") "/cf/master/cf"))

(defun coreform-get-root-dir ()
  "Coreform: check for a 'build' file in the version control root or use '~/cf/master/cf'."
  (if (file-exists-p (concat (vc-root-dir) "/build"))
      (vc-root-dir)
    coreform-root-default))

(defun coreform-get-build-dir ()
  "Coreform: return the build directory."
  (defvar-local build-dir (cond ((string-equal "darwin" (symbol-name system-type)) "build_mac64")
                                ((string-equal "windows-nt" (symbol-name system-type)) "build_win64")
                                (t "build_lin64")))
  (concat (coreform-get-root-dir)  "/../" build-dir))


(defun coreform-build (build-type)
  "Coreform: run 'build stage make'."
  (let ((default-directory (coreform-get-root-dir)))
    (defvar-local build-command (format "./build stage make build-type=%s" (symbol-name build-type)))
    (message build-command)
    (compile build-command)))

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

(defvar coreform-map
  (let ((map (make-sparse-keymap)))
    ;;(define-key map (kbd "C-d") 'coreform-build-debug)
    ;;(define-key map (kbd "C-r") 'coreform-build-release)
    (define-key map (kbd "d") 'coreform-ninja-debug)
    (define-key map (kbd "r") 'coreform-ninja-release)
    map)
  "Coreform: key map for Coreform utilities.")
(local-set-key (kbd "C-f") coreform-map)
