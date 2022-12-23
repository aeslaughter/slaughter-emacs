;;; slaughter-consult --- Setup consult.el
;;; Commentary:
;;; https://github.com/minad/consult

(slaughter-package-install 'corfu)
(require 'corfu)

(setq corfu-auto t
      corfu-auto-delay 0
      corfu-auto-prefix 0
      corfu-quit-no-match 'separator
      completion-styles '(orderless basic))

(add-hook 'after-init-hook 'global-corfu-mode)
(setq tab-always-indent 'complete)
(setq completion-cycle-threshold 3)
