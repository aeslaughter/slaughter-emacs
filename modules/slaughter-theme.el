;; install a theme

(slaughter-install-package 'cyberpunk-theme)
(load-theme 'cyberpunk t)

;; Font
(add-to-list 'default-frame-alist '(font . "Menlo-13" ))
(set-face-attribute 'default t :font "Menlo-13" )
