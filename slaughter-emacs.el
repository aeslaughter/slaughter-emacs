; Emacs for Andrew E Slaughter
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;(setq slaughter-package-list nil)

(package-initialize)
(package-refresh-contents)

(defun slaughter-install-package (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;(dolist (fname (directory-files "modules" nil "^slaughter-.*\.el"))
;  (load-file (concat "modules/" fname)))
               
(load-file "modules/slaughter-expand-region.el")
(load-file "modules/slaughter-helm.el")
(load-file "modules/slaughter-theme.el")


;(setq package-list (flatten-list slaughter-package-list))
;(print package-list);

; list the packages you want
;(setq package-list
;    '(python-environment deferred epc 
;        flycheck ctable jedi concurrent company cyberpunk-theme elpy 
;        yasnippet pyvenv highlight-indentation find-file-in-project 
;        sql-indent sql exec-path-from-shell iedit
;        auto-complete popup let-alist magit git-rebase-mode 
;        git-commit-mode minimap popup))


; activate all the packages
;(package-initialize)

; fetch the list of packages available 
;(unless package-archive-contents
;  (package-refresh-contents))

; install the missing packages
;(dolist (package package-list)
;  (unless (package-installed-p package)
;    (package-install package)))

;(defvar slaughter-emacs (switch-to-buffer "\*Slaughter Emacs\*"))
;(setq initial-buffer-choice "\*Slaughter Emacs\*")

;(load-file "modules/slaughter-expand-region.el")
