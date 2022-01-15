;; https://emacs-helm.github.io/helm/

(slaughter-package-install 'helm)
(require 'helm-config)
(recentf-mode 1)
(setq helm-ff-file-name-history-use-recentf 1)

(slaughter-package-install 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(slaughter-package-install 'helm-swoop)
(require 'helm-swoop)

; KEYBINDINGS
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x p") 'helm-projectile-find-file)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-s") 'helm-swoop)
