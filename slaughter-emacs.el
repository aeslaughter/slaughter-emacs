;;; Emacs for Andrew E Slaughter
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


(package-initialize)

;; install a package if it does not exist
(defun slaughter-package-install (pkg-name)
  (unless (package-installed-p pkg-name)
    (package-refresh-contents)
    (package-install pkg-name)))


(load-file "modules/slaughter-theme.el")
(load-file "modules/slaughter-helm.el")
(load-file "modules/slaughter-flycheck.el") ; requires helm
(load-file "modules/slaughter-company.el") ; requires helm
(load-file "modules/slaughter-undo.el") 
(load-file "modules/slaughter-expand-region.el")
(load-file "modules/slaughter-multiple-cursors.el")
;;(load-file "modules/slaughter-easy-kill.el")

(global-display-line-numbers-mode)
(setq line-numbers-mode t)
(set-face-foreground 'line-number "#444")

(setq require-final-newline t)

(delete-selection-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0) 

;; TODO:
;; - org mode for notes

;; todo: keybindings
;; create load slaughter-keybindings.el at top level
;; helm kill ring
;; delete line, after cursor, before cursor
;; newline above/below
;; copy line above/below
;; navigation C-left, C-up, ... to C-h, C-k, ... to mimic vi
;; go to definition M-> C-< ???
;;



