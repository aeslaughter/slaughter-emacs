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

;;(defvar-local this-directory (file-name-directory load-file-name))
(defvar-local this-directory "~/slaughter-emacs")
(load-file (concat this-directory "/modules/slaughter-theme.el"))
(load-file (concat this-directory "/modules/slaughter-projectile.el"))
(load-file (concat this-directory "/modules/slaughter-helm.el"))
(load-file (concat this-directory "/modules/slaughter-ivy.el"))
;; swoop/swiper...
(load-file (concat this-directory "/modules/slaughter-flycheck.el")) ; requires helm/ivy
(load-file (concat this-directory "/modules/slaughter-company.el"))
(load-file (concat this-directory "/modules/slaughter-undo.el"))
(load-file (concat this-directory "/modules/slaughter-expand-region.el"))
(load-file (concat this-directory "/modules/slaughter-multiple-cursors.el"))
(load-file (concat this-directory "/modules/slaughter-smartparens.el"))
(load-file (concat this-directory "/modules/slaughter-deft.el"))
(load-file (concat this-directory "/modules/slaughter-magit.el"))

(load-file (concat this-directory "/modules/slaughter-languages.el")) ;; TODO: add scribble

;;(load-file "modules/slaughter-easy-kill.el")

(global-display-line-numbers-mode)
(setq line-numbers-mode t)
(set-face-foreground 'line-number "#444")

(setq require-final-newline t)

(setq inhibit-startup-screen t)
(delete-selection-mode)
(setq tool-bar-mode 0)
(setq menu-bar-mode 0) 

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
   '(scribble-mode undo-tree typescript-mode smartparens seti-theme ripgrep racket-mode multiple-cursors markdown-mode magit helm flyspell-correct-ivy flycheck expand-region deft counsel-projectile company auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
