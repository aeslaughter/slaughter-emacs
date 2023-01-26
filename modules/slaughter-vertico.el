;;; slaughter-vertico --- Setup vertico for autoo completion
;;; Commentary:
;;; https://github.com/minad/vertico

(slaughter-package-install 'vertico)
(require 'vertico)
(vertico-mode)

(require 'vertico-directory)
(define-key vertico-map "\C-h" 'vertico-directory-up)
(define-key vertico-map "\C-k" 'vertico-previous)
(define-key vertico-map "\C-j" 'vertico-next)
(define-key vertico-map "\C-l" 'vertico-directory-enter)
