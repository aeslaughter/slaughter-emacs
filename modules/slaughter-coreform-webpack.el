;;; slaughter-coreform-webpack --- A package of utilities for runing Coreform webpack instances for GUI development.

;;; Code:
(require 'slaughter-coreform-build)
(require 'slaughter-coreform-process)

(defvar coreform-webpack--mode-v 'development
  "COREFROM-WEBPACK: Webpack development mode, should be set to 'development or 'release.")
(defvar coreform-webpack--watch-flag t
  "COREFROM-WEBPACK: Stores state for using --watch flag on webpack.")

(defun coreform-webpack--run (location process-name)
  "COREFORM-WEBPACK: run 'webpack' as a process with name PROCESS-NAME from the given LOCATION." 
  (let ((the-command (format "%s/node_modules/.bin/webpack" coreform--root-dir-v ))
        (the-args (list (format "--mode=%s" (symbol-name coreform-webpack--mode-v)) (if coreform-webpack--watch-flag "--watch" "--no-watch")  "--color")))
    (apply 'coreform-process--run location process-name the-command the-args)))

(add-to-list 'compilation-error-regexp-alist '(".*ERROR\\ *in\\ *\\(.*\\..*\\)(\\([0-9]+\\),\\([0-9]+\\))$" 1 2 3))

;; Interactive commands
(defun coreform-webpack-flex ()
  "COREFORM-WEBPACK: run webpack in the flex directory."
  (interactive)
  (coreform-webpack--run "/flex" "coreform-webpack-flex"))

(defun coreform-webpack-flex-restart ()
  "COREFORM-WEBPACK: stop and restart webpack in the flex directory."
  (interactive)
  (coreform-webpack-flex-kill)
  (coreform-webpack-flex))

(defun coreform-webpack-flex-kill ()
  "COREFORM-WEBPACK: kill the  webpack in the flex directory."
  (interactive)
  (coreform-process--kill  "coreform-webpack-flex"))

(defun coreform-webpack-cae ()
  "COREFORM-WEBPACK: run webpack in the cae directory."
  (interactive)
  (coreform-webpack--run "/cf_cae" "coreform-webpack-cae"))

(defun coreform-webpack-cae-kill ()
  "COREFORM-WEBPACK: kill the  webpack in the cae directory."
  (interactive)
  (coreform-process--kill  "coreform-webpack-cae"))

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
