;; https://github.com/magnars/expand-region.el

(slaughter-install-package 'expand-region)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;(setq this-directory (file-name-directory load-file-name))
;(setq root-directory (concat this-directory "../" ))

;(with-current-buffer slaughter-emacs
;  (goto-char (point-max))
;  (insert "some text to write"))

;(message "root-directory = %s" root-directory)


;(message "%s" "Initialize: slaughter-expand-region")

;(defun git-submodule-update (module)
;  (setq submodule-directory (concat root-directory "modules/submodules"))
;  (let ((default-directory submodule-directory))
;    (message "%s" (shell-command-to-string (concat "git submodule update --init" module)))))
;
;(git-submodule-update "expand-region.el")


;(message "%s" "Done: slaughter-expand-region")
