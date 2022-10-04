;; Spell checking with Flyspell and helm

(slaughter-package-install 'flycheck)
(require 'flycheck)
(slaughter-package-install 'dash)
(require 'dash)


(slaughter-package-install 'flycheck-aspell)
(require 'flycheck-aspell)


global-flycheck-mode)
(slaughter-package-install 'helm-flycheck)
(require 'helm-flycheck)

;(slaughter-package-install 'flyspell-correct-helm)
;(require 'flyspell-correct-helm)

;;(slaughter-package-install 'flyspell-correct-popup)
;;(require 'flyspell-correct-popup)


;;(slaughter-package-install 'flyspell-correct-ivy)
;;(require 'flyspell-correct-ivy)

;; slaughter 


;(add-hook 'text-mode-hook 'flyspell-mode)
;(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(define-key flyspell-mode-map (kbd "M-s") 'flyspell-correct-wrapper)

;(slaughter-package-install 'flycheck-vale)
;(require 'flycheck-vale)
;(flycheck-vale-setup)

(flycheck-define-checker vale
  "A checker for prose"
  :command ("vale" "--output" "line"
            source)
  :standard-input nil
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
  :modes (markdown-mode org-mode text-mode)
  )
(add-to-list 'flycheck-checkers 'vale 'append)
