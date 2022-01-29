;; https://github.com/magnars/expand-region.el

(slaughter-package-install 'expand-region)
(require 'expand-region)

;; KEYBINDINGS
(global-set-key (kbd "M-=") 'er/expand-region)
(global-set-key (kbd "M--") 'er/contract-region)

(global-set-key (kbd "M-]") 'er/mark-inside-pairs)
(global-set-key (kbd "M-\\") 'er/mark-outside-pairs)

(global-set-key (kbd "M-;") 'er/mark-inside-quotes)
(global-set-key (kbd "M-'") 'er/mark-outside-quotes)
