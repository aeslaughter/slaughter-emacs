;; Load the current buffers corresponding .hpp/.cpp file
(defun switch-hpp-cpp ()
  (message buffer-file-name)
  
  (setq fn (if (string-match-p "\\.hpp\\'" buffer-file-name)
               (replace-regexp-in-string "\\.hpp" ".cpp" buffer-file-name)
             (replace-regexp-in-string "\\.cpp" ".hpp" buffer-file-name)))

  ;; Open the file if it exists
  (if (file-exists-p fn)
      (find-file fn)
      (message "No file exists: %s" fn)))

(global-set-key (kbd "C-c c") (lambda () (interactive) (switch-hpp-cpp)))
;(define-key global-map "\C-cc" 'ff-other-file-alist)
