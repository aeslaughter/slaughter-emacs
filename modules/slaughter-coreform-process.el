;;; slaughter-coreform-process --- Manages processes for Coreform GUI development.

;;; Code:
(require 'slaughter-coreform-build)

(defun coreform-process--run (location process-name command &rest args)
  "COREFORM-PROCESS: run a COMMAND with ARGS as a process with name PROCESS-NAME from the given a LOCATION in the repository,"
  (interactive)
  (when (equal (process-status process-name) 'run)
    (when (yes-or-no-p (format "A webserver process '%s' is running, kill it? " process-name))
      (delete-process process-name)))
  (unless (equal (process-status process-name) 'run)
    (let ((default-directory (concat coreform--root-dir-v location))
          (buffer-name (format "*%s*" process-name)))
      (when (get-buffer buffer-name)
        (with-current-buffer buffer-name
          (read-only-mode -1)
          (erase-buffer)))
      (message "COREFORM-PROCESS: %s %s" command (string-join args))
      (apply 'start-process process-name buffer-name command args)
      (with-current-buffer buffer-name
        (compilation-mode)
        (read-only-mode))
      (unless (get-buffer-window buffer-name 'visible)
        (switch-to-buffer-other-window buffer-name)))))

(defun coreform-process--kill (process-name)
  "COREFORM-PROCESS: kill running webpack PROCESS-NAME"
  (interactive)
  (when (equal (process-status process-name) 'run)
    (delete-process process-name)))

(provide 'slaughter-coreform-process)
