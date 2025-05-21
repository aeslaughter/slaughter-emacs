;; deft
(slaughter-package-install 'deft)
(require 'deft)
(setq deft-default-extension "org")
(setq deft-directory "~/Google Drive/My Drive/notes")

;; build function to display deft commands
(defun deft-commands ()
  (interactive)
  (minibuffer-with-setup-hook
      (lambda ()
        (insert "deft"))
    (call-interactively #'execute-extended-command)))

;; override deft summary, I couldn't figure out how to do it with the deft-strimp-summary-regexp
;;(setq deft-strip-summary-regexp "#\\+TITLE:.*?^(?P<summary>.*)$")
(defun deft-parse-summary (contents title)
  (message contents)
  (string-match "\n\\(.*\\)\n.*" contents)
  (match-string 1 contents))

(defvar deft-window-offset 20
  "Offset width applied to Deft buffer window width.")

(defun deft-current-window-width ()
  "Return current width of window displaying `deft-buffer'.
If the frame has a fringe, it will absorb the newline.
Otherwise, we reduce the line length by a one-character offset."
  (let* ((window (get-buffer-window deft-buffer))
         (fringe-right (ceiling (or (cadr (window-fringes)) 0)))
         (offset (if (> fringe-right 0) 0 deft-window-offset)))
    (when window
      (- (window-text-width window) offset))))

;; KEYBINDINGS
(define-prefix-command 'deft-map)
(global-set-key "\C-d" 'deft-map)
(define-key deft-map "h" 'deft-commands)
(define-key deft-map "d" 'deft)
(define-key deft-map "n" 'deft-new-file)
