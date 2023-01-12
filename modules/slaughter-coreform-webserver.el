;;; slaughter-coreform-webserver --- A package of utilities for runing Coreform web server instances for GUI development.

;;; Code:
(require 'slaughter-coreform-process)

(defvar coreform-webserver--port-flex 61950
  "COREFORM_TEST: default port number for flex webserver.")

(defvar coreform-webserver--port-cae 61980
  "COREFORM_TEST: default port number for cf_cae webserver.")

(defun coreform-webserver--run (location port process-name)
  "COREFORM-WEBPACK: run a python webserver with PORT as a process with name PROCESS-NAME from the given LOCATION,\
   which must contain a .dist directory (as is created by webpack)."
  (let ((the-command "python3")
        (the-args (list "-m" "http.server" (number-to-string port) "--directory" "./dist")))
    (apply 'coreform-process--run location process-name the-command the-args)))


;; Interactive commands
(defun coreform-webserver-flex ()
  "COREFORM-WEBSERVER: run webserver in the flex directory."
  (interactive)
  (coreform-webserver--run "/flex" coreform-webserver--port-flex "coreform-webserver-flex"))

(defun coreform-webserver-flex-kill ()
  "COREFORM-WEBSERVER: kill the  webserver in the flex directory."
  (interactive)
  (coreform-process--kill "coreform-webserver-flex"))

(defun coreform-webserver-cae ()
  "COREFORM-WEBSERVER: run webserver in the cae directory."
  (interactive)
  (coreform-webserver-compile "/cf_cae" coreform-webserver--port-cae "coreform-webserver-cae"))

(defun coreform-webserver-cae-kill ()
  "COREFORM-WEBSERVER: kill the  webserver in the cae directory."
  (interactive)
  (coreform-process--kill "coreform-webserver-cae"))

(defun coreform-webserver-set-flex-port (port)
  "COREFORM-WEBSERVER: set the port for the flex webserver."
  (interactive (fornat "pSet port (current: %s, must be < 65535): " coreform-webserver--flex-cae))
  (setq coreform-webserver--port-flex port))

(defun coreform-webserver-set-cae-port (port)
  "COREFORM-WEBSERVER: set the port for the cae webserver."
  (interactive (fornat "pSet port (current: %s, must be < 65535): " coreform-webserver--port-cae))
  (setq coreform-webserver--port-cae port))

(provide 'slaughter-coreform-webserver)
