;;; slaughter-consult --- Setup consult.el
;;; Commentary:
;;; https://github.com/minad/consult
(slaughter-package-install 'rg)
(require 'rg)

(rg-enable-default-bindings)

(defun slaughter-rg/default-dir ()
	(let ((vc (vc-root-dir)))
	  (if vc
		  vc
		default-directory)))

(rg-define-search slaughter-rg/project-ask
  "SLAUGHTER-RG: prompted search current project or directory"
  :query ask
  :format regexp
  :files "everything"
  :dir (slaughter-rg/default-dir)
  :confirm prefix
  :flags ("--hidden -g !.git"))

(rg-define-search slaughter-rg/project-point
  "SLAUGHTER-RG: search text at location in current project or directory"
  :query point
  :format regexp
  :files "everything"
  :dir (slaughter-rg/default-dir)
  :confirm prefix
  :flags ("--hidden -g !.git"))

(rg-define-search slaughter-rg/file-ask
  "SLAUGHTER-RG: prompted search current file"
  :query ask
  :format regexp
  :files (rg-get-buffer-file-name)
  :dir current)

(rg-define-search slaughter-rg/file-ask
  "SLAUGHTER-RG: search test at location in current file"
  :query point
  :format regexp
  :files (rg-get-buffer-file-name)
  :dir current)

(define-prefix-command 'rg-map)
(global-set-key "\M-f" 'rg-map)
(define-key rg-map "p" 'slaughter-rg/project-ask)
(define-key rg-map "P" 'slaughter-rg/project-point)
(define-key rg-map "s" 'slaughter-rg/file-ask)
(define-key rg-map "S" 'slaughter-rg/file-ask)


