;;; slaughter-consult --- Setup consult.el
;;; Commentary:
;;; https://github.com/minad/consult

(slaughter-package-install 'consult)
(require 'consult)

;;;; Use `consult-completion-in-region' if Vertico is enabled.
;;;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))

;;;https://github.com/minad/consult/issues/399#issuecomment-1093122832
(defun get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

;; Ripgrep the current word from project root
(defun consult-ripgrep-at-point ()
  (interactive)
  (consult-ripgrep (get-project-root)(thing-at-point 'symbol)))

(defun consult-line-at-point ()
  (interactive)
  (consult-line (thing-at-point 'symbol)))

(defun consult-locate-at-point ()
  (interactive)
  (consult-locate (thing-at-point 'symbol)))

;; Create coreform map with prefix C-f
(define-prefix-command 'consult-map)
(global-set-key "\C-c" 'consult-map)

(define-key consult-map "s" 'consult-line)
(define-key consult-map "\C-s" 'consult-line-at-point)
(define-key consult-map "r" 'consult-ripgrep)
(define-key consult-map "\C-r" 'consult-ripgrep-at-point)
(define-key consult-map "l" 'consult-locate)
(define-key consult-map "\C-l" 'consult-locate-at-point)

