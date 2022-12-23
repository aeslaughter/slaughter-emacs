;;; Autocomplete using Helm and Company

(slaughter-package-install 'company)
(require 'company)
(setq company-dabbrev-downcase nil)
(add-hook 'after-init-hook 'global-company-mode)

