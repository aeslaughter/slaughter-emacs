;;; slaughter-vertico --- Setup vertico for autoo completion
;;; Commentary:
;;; https://github.com/minad/vertico

;;(slaughter-package-install consult)
;;(slaughter-package-install orderless)
;;(slaughter-package-install marginalia)

(slaughter-package-install 'vertico)
;;(slaughter-package-load "vertico" )
;;(load-file (concat contrib-dir "/vertico/vertico.el"))
(require 'vertico)
(vertico-mode)

(require 'vertico-directory)
(define-key vertico-map "\C-j" 'vertico-directory-up)
(define-key vertico-map "\C-l" 'vertico-directory-enter)


;; (define-key vertico-map "\r" #'vertico-directory-enter)
;; (define-key vertico-map "\d" #'vertico-directory-delete-char)
;; (define-key vertico-map "\M-\d" #'vertico-directory-delete-word)
;; (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy




;; Enable vertico
;;(use-package vertico
;;  :init
;;  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
;;  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
;;(use-package savehist
;;  :init
;;  (savehist-mode))

;; A few more useful configurations...
;;(use-package emacs
;;  :init
;;  ;; Add prompt indicator to `completing-read-multiple'.
;;  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
;;  (defun crm-indicator (args)
;;    (cons (format "[CRM%s] %s"
;;                  (replace-regexp-in-string
;;                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
;;                   crm-separator)
;;                  (car args))
;;          (cdr args)))
;;  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
;;
;;  ;; Do not allow the cursor in the minibuffer prompt
;;  (setq minibuffer-prompt-properties
;;        '(read-only t cursor-intangible t face minibuffer-prompt))
;;  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
;;
;;  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;;  ;; Vertico commands are hidden in normal buffers.
;;  ;; (setq read-extended-command-predicate
;;  ;;       #'command-completion-default-include-p)
;;
;;  ;; Enable recursive minibuffers
;;  (setq enable-recursive-minibuffers t))

;; Optionally use the `orderless' completion style.
;;(use-package orderless
;;  :init
;;  ;; Configure a custom style dispatcher (see the Consult wiki)
;;  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
;;  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
;;  (setq completion-styles '(orderless basic)
;;        completion-category-defaults nil
;;        completion-category-overrides '((file (styles partial-completion)))))
;;
;;
;;;; Use `consult-completion-in-region' if Vertico is enabled.
;;;; Otherwise use the default `completion--in-region' function.
;;(setq completion-in-region-function
;;      (lambda (&rest args)
;;        (apply (if vertico-mode
;;                   #'consult-completion-in-region
;;                 #'completion--in-region)
;;               args)))
;;
;;
;;(use-package consult)



;; Enable rich annotations using the Marginalia package
;;(use-package marginalia
;;  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
;;  :bind (("M-A" . marginalia-cycle)
;;         :map minibuffer-local-map
;;         ("M-A" . marginalia-cycle))

;;  ;; The :init configuration is always executed (Not lazy!)
;;  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
;;  (marginalia-mode))
