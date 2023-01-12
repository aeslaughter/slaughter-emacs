;;; slaughter-coreform-build --- Utilities for development at Coreform
;;; Commentary:

;;; Code:
;; Enable color for *compilation* buffer
(slaughter-package-install 'ansi-color)
;;emacs 28.1 ;;(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

(setq coreform--root-dir-v (concat (getenv "HOME") "/cf/master/cf"))

(defun coreform--get-root-dir-f ()
  "COREFORM: check for a 'build' file in the version control root or use '~/cf/master/cf'."
  (if (file-exists-p (concat (vc-root-dir) "/build"))
      (vc-root-dir)
    coreform--root-dir-v))

(defun coreform--select-buffer-window-f (buffer-name)
  "Coreform: switch to the window with a buffer of the given name"
  (let ((the-buffer (get-buffer-window buffer-name)))
    (if (not (equal the-buffer nil))
        (select-window the-buffer)))
  (message "COREFORM: switch to window with %s buffer" buffer-name))

(defun coreform-buffer-compilation ()
  "COREFORM: switch to *compilation* buffer."
  (interactive)
  (coreform--select-buffer-window-f "*compilation*"))

;;; Interactive commands:
(defun coreform-help ()
  "COREFORM: show all coreform-... commands"
  (interactive)
  (minibuffer-with-setup-hook
      (lambda ()
        (insert "coreform-"))
    (call-interactively #'execute-extended-command)))

(defun coreform-set-root-dir (directory)
  "COREFORM: set the root DIRECTORY to the 'cf' repository."
  (interactive (list (read-directory-name "Select coreform repository root directory? " 
                                          coreform--root-dir)))
  (message "Set coreform directory to  %s." directory)
  (setq coreform--root-dir directory))

;;; Sub-packages:
(let ((default-directory modules-directory))
  (load-file "slaughter-coreform-build.el")
  (load-file "slaughter-coreform-process.el")
  (load-file "slaughter-coreform-test.el")
  (load-file "slaughter-coreform-webpack.el")
  (load-file "slaughter-coreform-webserver.el"))

;;; Keybindings:
(define-prefix-command 'coreform-map)
(global-set-key "\C-f" 'coreform-map)

(define-key coreform-map "h" 'coreform-help)

(define-key coreform-map "t" 'coreform-test)
(define-key coreform-map "c" 'coreform-ctest)

(define-key coreform-map "d" 'coreform-build-ninja-debug)
(define-key coreform-map "\C-d" 'coreform-build-debug)

(define-key coreform-map "r" 'coreform-build-ninja-release)
(define-key coreform-map "\C-r" 'coreform-build-release)

(define-key coreform-map "b" 'coreform-buffer-compilation)

(provide 'slaughter-coreform)
;(define-package "slaughter" "1.98.0" "Package for Coreform development")
