;; Ivy

(slaughter-package-install 'ivy)
(require 'ivy)
(ivy-mode)
(counsel-mode)

(recentf-mode 1)
;;(setq helm-ff-file-name-history-use-recentf 1)
;;(setq helm-always-two-windows t)

(slaughter-package-install 'projectile)
(setq projectile-completion-system 'ivy)

(slaughter-package-install 'counsel-projectile)
;;(require 'helm-projectile)
;;(helm-projectile-on)

;; KEYBINDINGS
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;(global-set-key (kbd "C-x f") 'counsel-find-file)
(global-set-key (kbd "C-x C-r") 'counsel-recentf)
(global-set-key (kbd "C-x p") 'counsel-projectile-find-file)
(global-set-key (kbd "C-x b") 'counsel-projectile-switch-to-buffer)
(global-set-key (kbd "C-s") 'swiper)

;; this slaughter 
