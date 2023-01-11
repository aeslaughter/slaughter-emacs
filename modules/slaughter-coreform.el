;;; slaughter-coreform-build --- Utilities for development at Coreform
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



(setq coreform-webpack-mode 'development)
(setq coreform-webpack-watch t)



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



(defun coreform-kill-webpack ()
  "Coreform: kill running webpack process"
  (interactive))


(load-file "slaughter-coreform-build.el")
(load-file "slaughter-coreform-test.el")

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
