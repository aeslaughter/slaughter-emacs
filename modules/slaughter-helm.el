;; https://emacs-helm.github.io/helm/

(slaughter-install-package 'helm)
(require 'helm-config)

(slaughter-install-package 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(slaughter-install-package 'flycheck)
(global-flycheck-mode)

(slaughter-install-package 'helm-flycheck)
(require 'helm-flycheck)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file)


;(define-key flyspell-mode-map (kbd "M-s") #'flyspell-popup-correct)
