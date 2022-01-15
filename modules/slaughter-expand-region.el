;; https://github.com/magnars/expand-region.el

(slaughter-package-install 'expand-region)
(require 'expand-region)

;; KEYBINDINGS
(global-set-key (kbd "M-'") 'er/expand-region)
(global-set-key (kbd "M-;") 'er/contract-region)



