
;; LSP with eglot (this will be standard in emacs 29)
(slaughter-package-install 'eglot)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs
               '(c-mode . ("clangd"))))


(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
;;(add-hook 'racket-mode-hook #'lsp)

(slaughter-package-install 'typescript-mode)
(slaughter-package-install 'markdown-mode)
(slaughter-package-install 'racket-mode)
(slaughter-package-install 'scribble-mode)
(slaughter-package-install 'cmake-mode)
(slaughter-package-install 'company)
(slaughter-package-install 'yasnippet)

(add-hook 'scribble-mode-hook 'flyspell-mode)
(add-hook 'racket-mode-hook 'flyspell-mode)
(add-hook 'typescript-mode-hook 'flyspell-mode)
(add-hook 'c-mode-hook 'flyspell-mode)
(add-hook 'c++-mode-hook 'flyspell-mode)


(slaughter-package-install 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

(setq tide-format-before-save nil)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)


(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq-default c-basic-offset 8)
