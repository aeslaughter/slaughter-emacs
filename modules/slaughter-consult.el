;;; slaughter-consult --- Setup consult.el
;;; Commentary:
;;; https://github.com/minad/consult

(slaughter-package-install 'consult)
(require 'consult)

;;;; Use `consult-completion-in-region' if Vertico is enabled.
;;;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))


(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "C-x g") 'consult-ripgrep)
(global-set-key (kbd "C-x l") 'consult-locate)



