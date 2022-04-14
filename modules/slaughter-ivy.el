;; Ivy

(slaughter-package-install 'ivy)
(require 'ivy)
(ivy-mode)
(counsel-mode)

(recentf-mode 1)

(slaughter-package-install 'projectile)
(setq projectile-completion-system 'ivy)

(slaughter-package-install 'counsel-projectile)

;; KEYBINDINGS
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)

(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x r") 'counsel-buffer-or-recentf)
(global-set-key (kbd "C-x b") 'counsel-buffer-or-recentf)

(global-set-key (kbd "C-x g") 'counsel-projectile-rg)
(global-set-key (kbd "C-x p") 'counsel-projectile-find-file)
(global-set-key (kbd "C-x C-p") 'counsel-projectile-switch-project)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-u") 'swiper-thing-at-point)

;(defun swiper-isearch-again ()
;  (interactive)
;  (swiper-isearch (car swiper-history)))
;(global-set-key (kbd "C-s C-s") 'swiper-isearch-again)
