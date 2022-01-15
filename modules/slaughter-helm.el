;; https://emacs-helm.github.io/helm/

(slaughter-install-package 'helm)
(require 'helm-config)

(slaughter-install-package 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file)
