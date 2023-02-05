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

(defun slaughter-help (prefix)
  "SLAUGHTER: show all <prefix>... commands"
  (minibuffer-with-setup-hook
      (lambda ()
        (insert prefix))
    (call-interactively #'execute-extended-command)))

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
  (load-file "slaughter-switch-source.el")
  (load-file "slaughter-coreform.el")
  (load-file "slaughter-popper.el")
  (load-file "slaughter-trello.el"))

;; TODO: add keybindings.el???
(global-set-key "\C-c\C-u" 'comment-or-uncomment-region)
(global-set-key "\C-h" 'windmove-left) 
(global-set-key "\C-j" 'windmove-down)   
(global-set-key "\C-k" 'windmove-up) 
(global-set-key "\C-l" 'windmove-right)

(global-set-key "\M-9" 'backward-sexp)
(global-set-key "\M-0" 'forward-sexp)

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
 '(custom-safe-themes
   '("dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(package-selected-packages
   '(popper auto-dim-other-buffers golden-ratio vertico vterm-toggle vterm multi-term h5dump-mode helm-xref ivy-xref ivy-lsp flycheck-aspell lsp-ivy lsp-treemacs lsp-ui lsp-mode dumb-jump tide flyspell-correct-popup cmake-mode undo-tree typescript-mode swiper-helm smartparens seti-theme scribble-mode racket-mode projectile-ripgrep multiple-cursors markdown-mode magit highlight-parentheses helm-swoop helm-projectile helm-flycheck helm-company flyspell-correct-ivy flyspell-correct-helm expand-region easy-kill deft counsel-projectile browse-kill-ring)))
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
(setq-default indent-tabs-mode t)
(setq-default delete-trailing-lines t)
(setq default-tab-width 4)


(put 'erase-buffer 'disabled nil)
