(slaughter-package-install 'typescript-mode)
(slaughter-package-install 'markdown-mode)
(slaughter-package-install 'racket-mode)
(slaughter-package-install 'scribble-mode)

;;(load-file (concat this-directory "/modules/contrib/scribble-mode.el"))

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


