;;; slaughter-coreform-workspace --- Setup necessary workspace server instances for GUI development.

;;; Code:
(require 'slaughter-coreform-build)
(require 'slaughter-coreform-process)

(defvar coreform-workspace--port-v 61951
  "COREFORM-WORKSPACE: default port number for flex workspace.")

(defun coreform-workspace--run (location process-name)
  "COREFORM-WORKSPACE: run the flex workspace as a process with name PROCESS-NAME from the given LOCATION." 
  (let ((the-command (format "%s/flex_server" (coreform--get-binary-dir-f) ))
        (the-args (list (number-to-string coreform-workspace--port-v))))
    (apply 'coreform-process--run location process-name the-command the-args)))

;; Interactive commands
(defun coreform-workspace-flex ()
  "COREFORM-WORKSPACE: run workspace in the flex directory."
  (interactive)
  (coreform-workspace--run "/flex" "coreform-workspace-flex"))

(defun coreform-workspace-flex-kill ()
  "COREFORM-WORKSPACE: kill the  workspace in the flex directory."
  (interactive)
  (coreform-process--kill  "coreform-workspace-flex"))

(defun coreform-webserver-set-workspace-port (port)
  "COREFORM-WORKSPACE: set the port for the cae webserver."
  (interactive (fornat "pSet port (current: %s, must be < 65535): " coreform-webserver--port-v))
  (setq coreform-webserver--port-v port))


(provide 'slaughter-coreform-workspace)
