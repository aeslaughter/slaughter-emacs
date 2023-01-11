;;; Emacs for Andrew E Slaughter

(require 'package)

(add-to-list 'package-archives
             '("elpa" . "https://elpa.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; global variabls for directories
(setq root-dir "~/slaughter-emacs")
(setq contrib-dir (concat root-dir "/contrib"))

;; install a package if it does not exist
(defun slaughter-package-install (pkg-name)
  (unless (package-installed-p pkg-name)
    (package-refresh-contents)
    (package-install pkg-name)))

(defun slaughter-package-load (pkg-name &optional pkg-folder)
  (unless pkg-folder (setq pkg-folder pkg-name))
  (let ((defvar-local pkg-path (expand-file-name (concat contrib-dir "/" pkg-folder))))
    (message "Adding '%s' to load-path" pkg-path)
    (add-to-list 'load-path pkg-path)))


;;(defvar-local this-directory (file-name-directory load-file-name))

(defvar this-directory "~/slaughter-emacs")
(defvar modules-directory "~/slaughter-emacs/modules")
(let ((default-directory modules-directory))
  (load-file "slaughter-theme.el")
  (load-file "slaughter-projectile.el")
  (load-file "slaughter-vertico.el")
  (load-file "slaughter-orderless.el")
  (load-file "slaughter-consult.el")
  (load-file "slaughter-marginalia.el")  
  (load-file "slaughter-flycheck.el")
  (load-file "slaughter-undo.el")
  (load-file "slaughter-expand-region.el")
  (load-file "slaughter-multiple-cursors.el")
  (load-file "slaughter-smartparens.el")
  (load-file "slaughter-deft.el")
  (load-file "slaughter-magit.el") 
  (load-file "slaughter-languages.el")
  (load-file "slaughter-backup.el")  
  (load-file "slaughter-jump.el")
  (load-file "slaughter-switch-source.el")
  (load-file "slaughter-coreform.el")
  (load-file "slaughter-trello.el"))

;; TODO: add keybindings.el???
(global-set-key "\C-c\C-c" 'comment-or-uncomment-region)
(global-set-key "\C-h" 'windmove-left) 
(global-set-key "\C-j" 'windmove-down)   
(global-set-key "\C-k" 'windmove-up) 
(global-set-key "\C-l" 'windmove-right)

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq compilation-scroll-output t)
;;(setq compilation-auto-jump-to-first-error t)


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
   '(auto-dim-other-buffers golden-ratio vertico vterm-toggle vterm multi-term h5dump-mode helm-xref ivy-xref ivy-lsp flycheck-aspell lsp-ivy lsp-treemacs lsp-ui lsp-mode dumb-jump tide flyspell-correct-popup cmake-mode undo-tree typescript-mode swiper-helm smartparens seti-theme scribble-mode racket-mode projectile-ripgrep multiple-cursors markdown-mode magit highlight-parentheses helm-swoop helm-projectile helm-flycheck helm-company flyspell-correct-ivy flyspell-correct-helm expand-region easy-kill deft counsel-projectile browse-kill-ring)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-dim-other-buffers-face ((t (:background "color-233"))))
 '(helm-swoop-target-line-block-face ((t (:background "color-17"))))
 '(helm-swoop-target-line-face ((t (:background "color-22"))))
 '(helm-swoop-target-word-face ((t (:background "color-52")))))
(put 'upcase-region 'disabled nil)

;; whitespace and tabs
(setq-default indent-tabs-mode nil)
(setq-default delete-trailing-lines t)
(setq default-tab-width 4)


