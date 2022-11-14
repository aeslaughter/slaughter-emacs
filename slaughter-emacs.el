;;;; Emacs for Andrew E Slaughter

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
;;x(load-file (concat this-directory "/modules/slaughter-ivy.el"))
;; swoop/swiper...
(load-file (concat this-directory "/modules/slaughter-flycheck.el")) ; requires helm/ivy
(load-file (concat this-directory "/modules/slaughter-company.el"))
(load-file (concat this-directory "/modules/slaughter-undo.el"))
(load-file (concat this-directory "/modules/slaughter-expand-region.el"))
;(load-file (concat this-directory "/modules/slaughter-easy-kill.el"))
(load-file (concat this-directory "/modules/slaughter-multiple-cursors.el"))
(load-file (concat this-directory "/modules/slaughter-smartparens.el"))
(load-file (concat this-directory "/modules/slaughter-deft.el"))
(load-file (concat this-directory "/modules/slaughter-magit.el"))

(load-file (concat this-directory "/modules/slaughter-languages.el")) ;; TODO: add scribble
(load-file (concat this-directory "/modules/slaughter-backup.el"))

(load-file (concat this-directory "/modules/slaughter-jump.el"))
(load-file (concat this-directory "/modules/slaughter-switch-source.el"))

;;(load-file (concat this-directory "/modules/slaughter-eaf.el"))


(global-display-line-numbers-mode)
(setq line-numbers-mode t)
(set-face-foreground 'line-number "#444")

(setq require-final-newline t)

(setq inhibit-startup-screen t)
(delete-selection-mode)
(tool-bar-mode -1)
(menu-bar-mode -1) 
(global-auto-revert-mode t)

(setq inhibit-startup-screen t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(package-selected-packages
   '(helm-xref ivy-xref ivy-lsp flycheck-aspell lsp-ivy lsp-treemacs lsp-ui lsp-mode dumb-jump tide flyspell-correct-popup cmake-mode undo-tree typescript-mode swiper-helm smartparens seti-theme scribble-mode racket-mode projectile-ripgrep multiple-cursors markdown-mode magit highlight-parentheses helm-swoop helm-projectile helm-flycheck helm-company flyspell-correct-ivy flyspell-correct-helm expand-region easy-kill deft counsel-projectile browse-kill-ring)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-swoop-target-line-block-face ((t (:background "color-17"))))
 '(helm-swoop-target-line-face ((t (:background "color-22"))))
 '(helm-swoop-target-word-face ((t (:background "color-52")))))
(put 'upcase-region 'disabled nil)

;; whitespace and tabs
(setq-default indent-tabs-mode nil)
(setq-default delete-trailing-lines t)
(setq default-tab-width 4)


