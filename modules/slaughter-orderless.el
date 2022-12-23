;;; slaughter-orderless --- Setup orderless for auto completion
;;; Commentary:
;;; https://github.com/oantolin/orderless

(slaughter-package-install 'orderless)
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))
