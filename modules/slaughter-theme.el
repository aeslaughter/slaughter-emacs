;;; Theme, fonts, etc.


(slaughter-package-install 'doom-themes)
;;(load-theme 'doom-horizon t)
(load-theme 'doom-material t)

(global-linum-mode)
(setq linum-format "%4d \u2502 ")


(slaughter-package-install 'golden-ratio)
(require 'golden-ratio)
(golden-ratio-mode 1)
