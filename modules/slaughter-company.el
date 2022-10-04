;;; Autocomplete using Helm and Company

;(slaughter-package-install 'company)
(slaughter-package-install 'helm-company)

;(require 'company)
(require 'helm-company)

(global-company-mode)
(setq company-dabbrev-downcase nil)

;(define-key company-mode-map (kbd "C-:") 'helm-company)
;(define-key company-active-map (kbd "C-:") 'helm-company)
