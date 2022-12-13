
;; TODO: eglot will be included in emacs 29
(slaughter-package-install 'eglot)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs
               '(c-mode . ("clangd"))))

 
(slaughter-package-install 'typescript-mode)
(slaughter-package-install 'markdown-mode)
(slaughter-package-install 'racket-mode)
(slaughter-package-install 'scribble-mode)
(slaughter-package-install 'cmake-mode)
(slaughter-package-install 'company)

(add-hook 'scribble-mode-hook 'flyspell-mode)
(add-hook 'racket-mode-hook 'flyspell-mode)
(add-hook 'typescript-mode-hook 'flyspell-mode)
(add-hook 'c-mode-hook 'flyspell-mode)
(add-hook 'c++-mode-hook 'flyspell-mode)

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
;;(add-hook 'racket-mode-hook #'lsp)

(slaughter-package-install 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)


(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq-default c-basic-offset 4)
