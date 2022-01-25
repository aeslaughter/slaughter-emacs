;; https://emacs-helm.github.io/helm/

(slaughter-package-install 'helm)
(require 'helm-config)
;;(require 'helm-mode)

;;(recentf-mode 1)



;;(setq helm-ff-file-name-history-use-recentf 1)
(setq helm-always-two-windows t)
(setq helm-split-window-inside-p t)
;;(slaughter-package-install 'helm-projectile)
;;(require 'helm-projectile)
;;(helm-projectile-on)

;;(slaughter-package-install 'helm-swoop)
;;(require 'helm-swoop)
;;(slaughter-package-install 'swiper-helm)
;;(require 'swiper-helm)

; KEYBINDINGS
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
;;(global-set-key (kbd "C-x C-r") 'helm-recentf)
;;(global-set-key (kbd "C-x p") 'helm-projectile-find-file)
;;(global-set-key (kbd "C-x b") 'helm-mini)
;;(global-set-key (kbd "C-s") 'helm-swoop)
;;(global-set-key (kbd "C-s") 'helm-swoop-without-pre-input)
;;(global-set-key (kbd "C-s") 'swiper-helm)
;;(global-set-key (kbd "C-s C-s") 'swiper-thing-at-point)

;;(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
;;(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
;;(define-key helm-map (kbd "C-z") #'helm-select-action)

