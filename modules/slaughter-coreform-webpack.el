;;; slaughter-coreform-webpack --- A package of utilities for runing Coreform webpack instances for GUI development.

;;; Code:
(require 'slaughter-coreform-build)

(setq coreform-webpack--mode-v 'development)
(setq coreform-webpack--watch-flag t)

(defun coreform-webpack--run (location process-name)
  "COREFORM-WEBPACK: run 'webpack' as a process with name PROCESS-NAME from the given LOCATION." 
  (let ((default-directory (concat coreform--root-dir-v location))
        (the-command (format "%s/node_modules/.bin/webpack" coreform--root-dir-v ))
        (the-args (list (format "--mode=%s" (symbol-name coreform-webpack--mode-v)) (if coreform-webpack--watch-flag "--watch" "--no-watch")))
        (buffer-name (format "*%s*" process-name)))
    (when (get-buffer buffer-name)
      (with-current-buffer buffer-name
        (read-only-mode -1)
        (erase-buffer)))
    (message "COREFORM-WEBPACK: %s %s" the-command (string-join the-args))
    (apply 'start-process process-name buffer-name the-command the-args)
    (with-current-buffer buffer-name
      (compilation-mode)
      (read-only-mode))
    (unless (get-buffer-window buffer-name 'visible)
      (switch-to-buffer-other-window buffer-name))))

(defun coreform-webpack--kill (process-name)
  "COREFORM-WEBPACK: kill running webpack PROCESS_NAME"
  (interactive)
  (when (equal (process-status process-name) 'run)
    (delete-process process-name)))

;; Interactive commands
(defun coreform-webpack-compile (location process-name)
  "COREFORM-WEBPACK: run 'webpack' as a process with name PROCESS-NAME from the given LOCATION with a prompt for killing the current running process." 
  (interactive)
  (when (equal (process-status process-name) 'run)
    (when (yes-or-no-p (format "A webpack process '%s' is running, kill it? " process-name))
      (delete-process process-name)))
  (unless (equal (process-status process-name) 'run)
    (coreform-webpack--run location process-name)))

(defun coreform-webpack-flex ()
  "COREFORM-WEBPACK: run webpack in the flex directory."
  (interactive)
  (coreform-webpack-compile "/flex" "coreform-webpack-flex"))

(defun coreform-webpack-flex-kill ()
  "COREFORM-WEBPACK: kill the  webpack in the flex directory."
  (interactive)
  (coreform-webpack--kill  "coreform-webpack-flex"))

(defun coreform-webpack-cae ()
  "COREFORM-WEBPACK: run webpack in the cae directory."
  (interactive)
  (coreform-webpack-compile "/cf_cae" "coreform-webpack-cae"))

(defun coreform-webpack-cae-kill ()
  "COREFORM-WEBPACK: kill the  webpack in the cae directory."
  (interactive)
  (coreform-webpack--kill  "coreform-webpack-cae"))

(defun coreform-set-webpack-mode-development ()
  "COREFORM-WEBPACK: set the webpack mode to development."
  (interactive)
  (setq coreform-webpack--mode-v 'development))

(defun coreform-set-webpack-mode-release ()
  "COREFORM-WEBPACK: set the webpack mode to development"
  (interactive)
  (setq coreform-webpack--mode-v 'release))

(defun coreform-webpack-toggle-watch ()
  "COREFORM-WEBPACK: toggle the webpack watch flag"
  (interactive)
  (setq coreform-webpack--watch-flag (not coreform-webpack--watch-f))
  (message "COREFORM-WEBPACK: watch mode is %s" (if coreform-webpack--watch-flag "on" "off")))

(provide 'slaughter-coreform-webpack)
