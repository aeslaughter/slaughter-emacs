;;; Multiple cursor support

(slaughter-package-install 'multiple-cursors)
(require 'multiple-cursors)

;; KEYBINDINGS
(global-set-key (kbd "M-<return>") 'set-rectangular-region-anchor)
(global-set-key (kbd "M-RET") 'set-rectangular-region-anchor)
