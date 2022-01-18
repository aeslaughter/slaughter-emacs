;;; Emacs for Andrew E Slaughter
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


;; slaughtr 

(package-initialize)

;; install a package if it does not exist
(defun slaughter-package-install (pkg-name)
  (unless (package-installed-p pkg-name)
    (package-refresh-contents)
    (package-install pkg-name)))

;;(defvar-local this-directory (file-name-directory load-file-name))
(defvar-local this-directory "~/slaughter-emacs")
(load-file (concat this-directory "/modules/slaughter-theme.el"))
(load-file (concat this-directory "/modules/slaughter-projectile.el"))
(load-file (concat this-directory "/modules/slaughter-helm.el"))
;;(load-file (concat this-directory "/modules/slaughter-ivy.el"))
;; swoop/swiper...
(load-file (concat this-directory "/modules/slaughter-flycheck.el")) ; requires helm/ivy
(load-file (concat this-directory "/modules/slaughter-company.el"))
(load-file (concat this-directory "/modules/slaughter-undo.el"))
(load-file (concat this-directory "/modules/slaughter-expand-region.el"))
(load-file (concat this-directory "/modules/slaughter-multiple-cursors.el"))
(load-file (concat this-directory "/modules/slaughter-languages.el"))

;;(load-file "modules/slaughter-easy-kill.el")

(global-display-line-numbers-mode)
(setq line-numbers-mode t)
(set-face-foreground 'line-number "#444")

(setq require-final-newline t)

(setq inhibit-startup-screen t)
(delete-selection-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0) 
(setq inhibit-startup-screen t)
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



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(multiple-cursors expand-region undo-tree helm-company company flyspell-correct-helm helm-flycheck flycheck helm-swoop helm-projectile helm seti-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
