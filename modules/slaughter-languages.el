;;(slaughter-package-install 'eglot)

;;(slaughter-package-install 'lsp-mode)
;;(slaughter-package-install 'lsp-ui)
;;(slaughter-package-install 'lsp-treemacs)
;;(slaughter-package-install 'lsp-ivy)
;
;;(lsp-install-server 'clangd)
;;(lsp-install-server 'ts-ls)

(slaughter-package-install 'typescript-mode)
(slaughter-package-install 'markdown-mode)
(slaughter-package-install 'racket-mode)
(slaughter-package-install 'scribble-mode)
(slaughter-package-install 'cmake-mode)
(slaughter-package-install 'company)

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





