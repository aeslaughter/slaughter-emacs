;;; Theme, fonts, etc.



(slaughter-package-install 'seti-theme)
(load-theme 'seti t)

;; Font
(add-to-list 'default-frame-alist '(font . "Menlo-13" ))
(set-face-attribute 'default t :font "Menlo-13" )

(set-face-attribute 'region nil :background "#555")
(set-face-attribute 'highlight nil :background "#444")

(set-face-foreground 'font-lock-string-face "#AAFF00")
(set-face-foreground 'font-lock-comment-face "#005FAF")


;;(set-face-background 'helm-swoop-target-word-face "#AAFF00")

