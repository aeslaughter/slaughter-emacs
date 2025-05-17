(slaughter-package-install 'ripgrep)
(slaughter-package-install 'projectile)
(projectile-global-mode)

(setq projectile-project-search-path '(("~/projects/" 2)))
(setq projectile-sort-order 'recentf)


;; KEYBINDINGS
(global-set-key (kbd "C-x p") 'projectile-find-file)
