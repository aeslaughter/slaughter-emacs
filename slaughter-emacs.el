;;; slaughter-emacs --- Emacs for Andrew E Slaughter
;;; Commentary:
;;; Setup Emacs that is the most bestest



;;; Code:
(require 'package)

;; always install it
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(add-to-list 'package-archives
             '("elpa" . "https://elpa.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(setq project-dirs '("~/projects/m3works/awsm"
                     "~/projects/m3works/scriptomatic"))



;; THEME
(use-package emacs
  :init
  (load-theme 'wombat))

;; (use-package doom-themes
;;   :init
;;   (load-theme 'doom-material t))

;; PROJECTILE
;; http=s://github.com/bbatsov/projectile

;; Optional: which-key will show you options for partially completed keybindings
;; It's extremely useful for packages with many keybindings like Projectile.
(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path "~/projects/m3works")
  :config
  ;; I typically use this keymap prefix on macOS
  ;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; On Linux, however, I usually go with another one
  (define-key projectile-mode-map (kbd "C-p") 'projectile-command-map)
  ;; (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; (use-package projectile
;;   :init
;;   (projectile-mode)
;;   (setq projectile-project-search-path '(("~/projects/" 2)))
;;   (setq projectile-sort-order 'recentf)
;;   :bind
;;   ("C-x p" . projectile-find-file))
  
;; RIPGREP w/ PROJECTILE
;; https://github.com/dajva/rg.el
(use-package ripgrep)
;;  :if (eq system-type 'darwin)
;;  :ensure-system-package ((ripgrep . "brew install ripgrep")))


;; VERTICO
(use-package vertico
  :init
  (vertico-mode)
  :bind (:map vertico-map
  ("C-b" . vertico-directory-up)
  ("C-p" . vertico-previous)
  ("C-n" . vertico-next)
  ("C-f" . vertico-directory-enter)))


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
  :bind (:map copilot-completion-map
	      ("TAB" . copilot-accept-completion)
	      ("C-TAB" . copilot-accept-completion-by-word)))
(use-package copilot-chat)


;; UNDO
(use-package undo-tree
  :config
  (global-undo-tree-mode))


;; CONSULT
(use-package consult)

;; Use `consult-completion-in-region' if Vertico is enabled.
;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   'consult-completion-in-region
                 'completion--in-region)
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

(defun cronsult-locate-at-point ()
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

;; EXPAND REGION
(use-package expand-region
  :bind
  ("M-=" . er/expand-region)
  ("M--" . er/contract-region)
  ("M-]" . er/mark-inside-pairs)
  ("M-\\" . er/mark-outside-pairs)
  ("M-;" . er/mark-inside-quotes)
  ("M-'" . er/mark-outside-quotes))

;; MULTIPLE CURSORS
(use-package multiple-cursors
  :bind
  ("M-<return>" . set-rectangular-region-anchor)
  ("M-RET" . set-rectangular-region-anchor))
 
;; TEXT MOVE UP/DOWN
(use-package drag-stuff
  :init
  (drag-stuff-mode t)
  :bind
  ("M-p" . drag-stuff-up)
  ("M-n" . drag-stuff-down))
(use-package markdown-mode
  :bind
  (:map markdown-mode-map
        ("M-p" . drag-stuff-up)
        ("M-n" . drag-stuff-down)))

  
;; SMARTPARENS
(use-package smartparens
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :init
  (smartparens-mode)
  (smartparens-global-mode)
  (show-smartparens-mode)
  (show-smartparens-global-mode)
  :config
  (require 'smartparens-config))

;; HIGHLIGHT PARENS 
(use-package highlight-parentheses
  :hook
  (prog-mode . highlight-parentheses-mode)
  :custom
  (highlight-parentheses-colors '("green1" "red1" "blue1" "orchid1")))



;; MAGIT
(use-package magit)


;; TERMINAL
(use-package vterm
  :bind
  ("C-t" . vterm))

;;; Interactive commands:
;; (defun magit-help ()
;;   "MAGIT: show all magit-... commands"
;;   (interactive)
;;   (slaughter-help "magit-"))

;;; Keybindings:
(define-prefix-command 'magit-map)
(global-set-key "\C-t" 'magit-map)
(define-key magit-map "h" 'magit-help)
(define-key magit-map "s" 'magit-status)
(define-key magit-map "<up>" 'smerge-keep-upper)
(define-key magit-map "<down>" 'smerge-keep-lower)
(define-key magit-map "a" 'smerge-keep-all)
(define-key magit-map "n" 'smerge-next)
(define-key magit-map "p" 'smerge-prev)

;; PYTHON
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (python-mode . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :commands
  lsp)

(add-hook 'lsp-after-initialize-hook
          (lambda ()
            (lsp-workspace-folders-add "~/projects/m3works/aswm")
            (lsp-workspace-folders-add "~/projects/m3works/scriptomatic")))



;; (use-package elpy
;;   :init
;;   (elpy-enable))

;; (use-package jedi)

;; lsp-ui
;; lsp-treemacs
;; dap-mode 

(use-package python-mode
  :custom
  (python-shell-interpreter "python3")
  :hook
  (python-mode . lsp-deferred))

;;(use-package ruff-format)

(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/projects/notes"
                deft-extensions '("md" "txt" "org")))
(define-prefix-command 'deft-map)
(global-set-key "\C-d" 'deft-map)
(define-key deft-map "h" 'deft-commands)
(define-key deft-map "d" 'deft)
(define-key deft-map "n" 'deft-new-file)



;; (use-package eaf
;;   :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
;;   :custom
;;   ; See https://github.com/emacs-eaf/emacs-application-framework/wiki/Customization
;;   (eaf-browser-continue-where-left-off t)
;;   (eaf-browser-enable-adblocker t)
;;   (browse-url-browser-function 'eaf-open-browser)
;;   :config
;;   (defalias 'browse-web #'eaf-open-browser)
;;   (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
;;   (eaf-bind-key take_photo "p" eaf-camera-keybinding)
;;   (eaf-bind-key nil "M-q" eaf-browser-keybinding)) 


;; General setup
;; (setq compilation-auto-jump-to-first-error t)
(setq require-final-newline t)
(setq inhibit-startup-screen t)
(delete-selection-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-auto-revert-mode t)

(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)


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
(setq-default indent-tabs-mode nil)
(setq-default delete-trailing-lines t)
(setq-default default-tab-width 4)
;;(setq compilation-auto-jump-to-first-error t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738"
     "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
