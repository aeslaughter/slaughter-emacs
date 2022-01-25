;; Spell checking with Flyspell and helm

(slaughter-package-install 'flycheck)
(require 'flycheck)
(slaughter-package-install 'dash)
(require 'dash)

;(global-flycheck-mode)
;;(slaughter-package-install 'helm-flycheck)
;;(require 'helm-flycheck)

;;(slaughter-package-install 'flyspell-correct-helm)
;;(require 'flyspell-correct-helm)

(slaughter-package-install 'flyspell-correct-ivy)
(require 'flyspell-correct-ivy)

;; slaughter 


(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)


(define-key flyspell-mode-map (kbd "M-s") 'flyspell-correct-wrapper)
