;; deft
(slaughter-package-install 'deft)
(require 'deft)
(setq deft-default-extension "org")
(setq deft-directory "~/Google Drive/My Drive/notes")

;; KEYBINDINGS
(define-prefix-command 'deft-map)
(global-set-key "\C-d" 'deft-map)

(define-key deft-map "d" 'deft)
(define-key deft-map "n" 'deft-new-file)


(setq deft-strip-summary-regexp "#\\+TITLE:.*?^(?P<summary>.*)$")
