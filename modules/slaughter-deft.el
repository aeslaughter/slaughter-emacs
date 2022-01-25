;; deft
(slaughter-package-install 'deft)
(require 'deft)
(setq deft-default-extension "org")
(setq deft-directory "~/Google Drive/My Drive/notes")

;; KEYBINDINGS
(global-set-key (kbd "C-x n") 'deft)



