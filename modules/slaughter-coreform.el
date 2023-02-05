;;; slaughter-coreform-build --- Utilities for development at Coreform
;;; Commentary:

;;; Code:
;; Enable color for *compilation* buffer
(slaughter-package-install 'ansi-color)
;;emacs 28.1 ;;(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(require 'ansi-color)
(defun coreform-colorize-compilation-buffer ()
  (interactive)
  (when (eq major-mode 'compilation-mode)
    (ansi-color-apply-on-region compilation-filter-start (point-max))))
(add-hook 'compilation-filter-hook 'coreform-colorize-compilation-buffer)

(setq coreform--root-dir-v (concat (getenv "HOME") "/cf/master/cf"))

(defun coreform--get-root-dir-f ()
  "COREFORM: check for a 'build' file in the version control root or use '~/cf/master/cf'."
  (if (file-exists-p (concat (vc-root-dir) "/build"))
      (vc-root-dir)
    coreform--root-dir-v))

(defun coreform--select-buffer-window-f (buffer-name)
  "COREFORM: select the window with a buffer of the given BUFFER-NAME."
  (let ((the-buffer (get-buffer-window buffer-name)))
    (if (not (equal the-buffer nil))
        (select-window the-buffer)))
  (message "COREFORM: switch to window with %s buffer" buffer-name))

(defun coreform--delete-buffer-window-f (buffer-name)
  "COREFORM: delete the window with a buffer of the given BUFFER-NAME."
  (let ((the-window (get-buffer-window buffer-name 'visible)))
    (when the-window (delete-window the-window)))
  (message "COREFORM: delete window with %s buffer" buffer-name))


;;; Sub-packages:
(let ((default-directory modules-directory))
  (load-file "slaughter-coreform-build.el")
  (load-file "slaughter-coreform-process.el")
  (load-file "slaughter-coreform-test.el")
  (load-file "slaughter-coreform-webpack.el")
  (load-file "slaughter-coreform-webserver.el")
  (load-file "slaughter-coreform-workspace.el"))

;;; Interactive commands:
(defun coreform-help ()
  "COREFORM: show all coreform-... commands"
  (interactive)
  (slaughter-help "coreform-"))

(defun coreform-set-root-dir (directory)
  "COREFORM: set the root DIRECTORY to the 'cf' repository."
  (interactive (list (read-directory-name "Select coreform repository root directory? " 
                                          coreform--root-dir)))
  (message "Set coreform directory to  %s." directory)
  (setq coreform--root-dir directory))

(defun coreform-dev-flex ()
  (interactive)
  (coreform-build)
  (coreform-workspace-flex-restart)
  (coreform-webpack-flex-restart)
  (coreform-webserver-flex-restart))

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

(define-key coreform-map "1" 'coreform-dev-flex)
(define-key coreform-map "2" 'coreform-webpack-flex-restart)
(define-key coreform-map "3" 'coreform-workspace-flex-restart)
(define-key coreform-map "4" 'coreform-webserver-flex-restart)



(setq-default tab-width 4)

(provide 'slaughter-coreform)
;(define-package "slaughter" "1.98.0" "Package for Coreform development")
