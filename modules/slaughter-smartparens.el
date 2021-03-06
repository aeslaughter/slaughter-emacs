(slaughter-package-install 'smartparens)
(require 'smartparens-config)
(smartparens-mode)
(smartparens-global-mode)
(show-smartparens-mode)
(show-smartparens-global-mode)

(set-face-background 'sp-pair-overlay-face "Color-18")
(slaughter-package-install 'highlight-parentheses)
(require 'highlight-parentheses)
(add-hook 'prog-mode-hook #'highlight-parentheses-mode)
(setq highlight-parentheses-colors '("green1" "red1" "blue1" "orchid1"))
