;;; Theme, fonts, etc.


(slaughter-package-install 'doom-themes)
(load-theme 'doom-horizon t)
;;(load-theme 'doom-material t)

(global-linum-mode)
(setq linum-format "%4d \u2502 ")


(slaughter-package-install 'zoom)
(require 'zoom)
(zoom-mode nil)
;; (setq zoom-size '(0.5 . 0.5))
;; (temp-buffer-resize-mode t)


;; (slaughter-package-install 'auto-dim-other-buffers)
;; (auto-dim-other-buffers-mode f)
