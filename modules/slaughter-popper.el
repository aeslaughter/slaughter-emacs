;;; slaughter-consult --- Setup consult.el
;;; Commentary:
;;; https://github.com/minad/consult
(slaughter-package-install 'popper)
(require 'slaughter-coreform)


(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
		"\\*rg\\*"
        help-mode
        compilation-mode))


(define-prefix-command 'popper-map)
(global-set-key "\C-p" 'popper-map)

(define-key popper-map "p" 'popper-toggle-latest)
(define-key popper-map "c" 'popper-cycle)
(define-key popper-map "t" 'popper-toggle-type)


(popper-mode +1)

;; For echo-area hints
(require 'popper-echo)
(popper-echo-mode +1)

