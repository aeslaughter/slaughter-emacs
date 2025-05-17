;;; -*- lexical-binding: t -*-
;;; slaughter-emacs.el --- Emacs for Andrew E Slaughter
;;; Comentary: Setup emacs that is the most bestest

(require 'package)

;; always install it
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(add-to-list 'package-archives
             '("elpa" . "https://elpa.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)


;; THEME
(use-package doom-themes
  :init
  (load-theme 'doom-material t))

(global-display-line-numbers-mode 1)

;; PROJECTILE
;; https://github.com/bbatsov/projectile
(use-package projectile
  :init
  (projectile-global-mode)
  :custom
  (setq projectile-project-search-path '(("~/projects/" 2)))
  (setq projectile-sort-order 'recentf)
  (global-set-key (kbd "C-x p") 'projectile-find-file))
  
;; RIPGREP w/ PROJECTILE
;; https://github.com/dajva/rg.el
(use-package ripgrep)
;;  :if (eq system-type 'darwin)
;;  :ensure-system-package ((ripgrep . "brew install ripgrep")))


;; VERTICO
(use-package vertico
  :init
  (vertico-mode)
  :custom
  (define-key vertico-map "\C-h" 'vertico-directory-up)
  (define-key vertico-map "\C-k" 'vertico-previous)
  (define-key vertico-map "\C-j" 'vertico-next)
  (define-key vertico-map "\C-l" 'vertico-directory-enter))


;; ORDERLESS
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))


;; COPILOT
(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el"
            :rev :newest
           :branch "main")
  :hook
  (prog-mode . copilot-mode)
  (prog-mode . (lambda () (setq-local standard-indent 4)))
  :config
  (setq copilot-indentation-alist '((prog-mode 4) (python-mode 4) (c-mode 4) (c++-mode 4)))
  :bind (:map copilot-mode-map
              ("C-<return>" . copilot-accept-completion)))

;; CONSULT
(use-package consult)

;; Use `consult-completion-in-region' if Vertico is enabled.
;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))

;;;https://github.com/minad/consult/issues/399#issuecomment-1093122832
(defun get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

;; Ripgrep the current word from project root
(defun consult-ripgrep-at-point ()
  (interactive)
  (consult-ripgrep (get-project-root)(thing-at-point 'symbol)))

(defun consult-line-at-point ()
  (interactive)
  (consult-line (thing-at-point 'symbol)))

(defun consult-locate-at-point ()
  (interactive)
  (consult-locate (thing-at-point 'symbol)))

(define-prefix-command 'consult-map)
(global-set-key (kbd "C-c") 'consult-map)

(define-key consult-map "s" 'consult-line)
(define-key consult-map "\C-s" 'consult-line-at-point)
(define-key consult-map "r" 'consult-ripgrep)
(define-key consult-map "\C-r" 'consult-ripgrep-at-point)
(define-key consult-map "l" 'consult-locate)
(define-key consult-map "\C-l" 'consult-locate-at-point)


;; MARGINILIA
;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))


;; FLYCHECK - SPELL CHECKING
(use-package flycheck
  :init
  (global-flycheck-mode)
  )


(use-package flycheck-aspell)
(use-package flyspell-correct-popup)

(define-key flyspell-mode-map (kbd "M-s") 'flyspell-correct-wrapper)

;; Expand Region
(use-package multiple-cursors
  :bind
  ("M-<return>" . set-rectangular-region-anchor)
  ("M-RET" . set-rectangular-region-anchor))
 


(use-package drag-mode
  :bind
  ("M-p" . drag-mode-up)
  ("M-n" . drag-mode-down))
  
  



;; (setq compilation-auto-jump-to-first-error t)

;; General setup
(setq require-final-newline t)
(setq inhibit-startup-screen t)
(delete-selection-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-auto-revert-mode t)

(setq inhibit-startup-screen t)


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


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(column-number-mode t)
;;  '(custom-safe-themes
;;    '("250007c5ae19bcbaa80e1bf8184720efb6262adafa9746868e6b9ecd9d5fbf84" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "ae426fc51c58ade49774264c17e666ea7f681d8cae62570630539be3d06fd964" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
;;  '(package-selected-packages
;;    '(codeium csv-mode rg modus-themes popper auto-dim-other-buffers golden-ratio vertico vterm-toggle vterm multi-term h5dump-mode helm-xref ivy-xref ivy-lsp flycheck-aspell lsp-ivy lsp-treemacs lsp-ui lsp-mode dumb-jump tide flyspell-correct-popup cmake-mode undo-tree typescript-mode swiper-helm smartparens seti-theme scribble-mode racket-mode projectile-ripgrep multiple-cursors markdown-mode magit highlight-parentheses helm-swoop helm-projectile helm-flycheck helm-company flyspell-correct-ivy flyspell-correct-helm expand-region easy-kill deft counsel-projectile browse-kill-ring)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(auto-dim-other-buffers-face ((t (:background "color-233"))))
;;  '(helm-swoop-target-line-block-face ((t (:background "color-17"))))
;;  '(helm-swoop-target-line-face ((t (:background "color-22"))))
;;  '(helm-swoop-target-word-face ((t (:background "color-52")))))
;; (put 'upcase-region 'disabled nil)

;; whitespace and tabs
(setq-default indent-tabs-mode nil)
(setq-default delete-trailing-lines t)
(setq default-tab-width 4)


;; (put 'erase-buffer 'disabled nil)
;; (custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(package-selected-packages nil)
 ;;'(package-vc-selected-packages
 ;;  '((copilot :url "https://github.com/copilot-emacs/copilot.el" :branch
;;"main"))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; )
