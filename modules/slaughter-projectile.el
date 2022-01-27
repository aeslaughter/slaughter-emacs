(slaughter-package-install 'ripgrep)
(slaughter-package-install 'projectile)
(projectile-global-mode)

;; KEYBINDINGS
(global-set-key (kbd "C-x g") 'projectile-ripgrep)


