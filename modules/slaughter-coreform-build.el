;;; slaughter-coreform --- A package of utilities for Coreform development with emacs.
;;; Summary: All the things for Coreform software development with emacs...

;;; Code:
(defvar coreform-build--type-v 'debug
  "COREFORM-BUILD: the current build type: 'release or 'debug.")

(defun coreform-build--get-dir-f ()
  "COREFORM-BUILD: return the build directory."
  (let ((build-dir (cond ((string-equal "darwin" (symbol-name system-type)) "build_mac64")
                         ((string-equal "windows-nt" (symbol-name system-type)) "build_win64")
                         (t "build_lin64"))))
    (expand-file-name (concat (coreform--get-root-dir-f)  "/../" build-dir))))

(defun coreform--get-binary-dir-f ()
  "COREFORM: return the binary directory."
  (let ((binary-dir (cond ((eq coreform-build--type-v 'debug) "/bin/Debug")
                                 (t "/bin/Release"))))
    (concat (coreform-build--get-dir-f) binary-dir)))

(defun coreform-build--make-f ()
  "COREFORM-BUILD: run 'build stage make' using the current build type."
  (let ((default-directory (coreform--get-root-dir-f))
        (build-command (format "./build stage make --build-type=%s" (symbol-name coreform-build--type-v))))
    (message "coreform-build: %s" build-command)
    (compile build-command)))

(defun coreform-build--ninja-f ()
  "COREFORM-BUILD: run ninja using the current build type."
  (let ((default-directory (coreform-build--get-dir-f))
        (ninja-command (cond ((eq coreform-build--type-v 'debug) "ninja -f build-Debug.ninja")
                             ((eq coreform-build--type-v 'release) "ninja -f build-Release.ninja")
                             (t "ninja -f build.ninja"))))
    (message "coreform-build: %s" ninja-command)
    (compile ninja-command)))

;;; Interactive commands:
(defun coreform-build ()
  "COREFORM_BUILD: configure and compile in debug mode."
  (interactive)
  (coreform-build--make-f)
  (coreform-buffer-compilation))

(defun coreform-build-debug ()
  "COREFORM_BUILD: configure and compile in debug mode."
  (interactive)
  (setq coreform-build--type-v 'debug)
  (coreform-build--make-f)
  (coreform-buffer-compilation))

(defun coreform-build-release ()
  "COREFORM-BUILD: configure and compile in release mode."
  (interactive)
  (setq coreform-build--type-v 'release)
  (coreform-build--make-f)
  (coreform-buffer-compilation))

(defun coreform-build-ninja-debug ()
  "COREFORM-BUILD: build with ninja in debug mode."
  (interactive)
  (setq coreform-build--type-v 'debug)
  (coreform-build--ninja-f)
  (coreform-buffer-compilation))

(defun coreform-build-ninja-release ()
  "COREFORM-BUILD: build with ninja in release mode."
  (interactive)
  (setq coreform-build--type-v 'release)
  (coreform-build--ninja-f)
  (coreform-buffer-compilation))

(defun coreform-build-set-type-debug ()
  "COREFORM-BUILD: set the build type to debug."
  (interactive)
  (setq coreform-build--type-v 'debug))

(defun coreform-build-set-type-release ()
  "COREFORM-BUILD: set the build type to release."
  (interactive)
  (setq coreform-build--type-v 'release))


(provide 'slaughter-coreform-build)
