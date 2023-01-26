;; magit
(slaughter-package-install 'magit)


;;; Interactive commands:
(defun magit-help ()
  "MAGIT: show all magit-... commands"
  (interactive)
  (slaughter-help "magit-"))

;;; Keybindings:
(define-prefix-command 'magit-map)
(global-set-key "\C-t" 'magit-map)
(define-key magit-map "h" 'magit-help)
(define-key magit-map "s" 'magit-status)
(define-key magit-map "<up>" 'smerge-keep-upper)
(define-key magit-map "<down>" 'smerge-keep-lower)
(define-key magit-map "a" 'smerge-keep-all)

(define-key magit-map "n" 'smerge-next)
(define-key magit-map "p" 'smerge-prev)
