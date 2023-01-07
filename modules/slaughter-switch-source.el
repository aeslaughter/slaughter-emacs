;; Load the current buffers corresponding .hpp/.cpp file
(defun switch-hpp-cpp ()
  ;;(message buffer-file-name)

  ;;(setq bse (file-name-sans-extension buffer-file-name))
  ;; and the extension, converted to lowercase so we can
  ;; compare it to "h", "c", "cpp", etc
  (setq ext (downcase (file-name-extension buffer-file-name)))

  (cond
   ((string-match-p "\\.hp\\{0,2\\}\\'" buffer-file-name)
    (setq cpp_local (replace-regexp-in-string "\\.hp\\{0,2\\}\\'" ".cpp" buffer-file-name))
    (setq cpp_src (replace-regexp-in-string "/include/" "/src/" cpp_local))
    (setq c_local (replace-regexp-in-string "\\.hp\\{0,2\\}\\'" ".C" buffer-file-name))
    (setq c_src (replace-regexp-in-string "/include/" "/src/" c_local))
    (cond
     ((file-exists-p cpp_local) (find-file cpp_local))
     ((file-exists-p cpp_src) (find-file cpp_src))
     ((file-exists-p c_local) (find-file c_local))
     ((file-exists-p c_src) (find-file c_src))
     ))
   ((string-match-p "\\.cp\\{0,2\\}\\'" buffer-file-name)
    (setq hpp_local (replace-regexp-in-string "\\.cp\\{0,2\\}\\'" ".hpp" buffer-file-name))
    (setq hpp_src (replace-regexp-in-string "/src/" "/include/" hpp_local))
    (setq h_local (replace-regexp-in-string "\\.cp\\{0,2\\}\\'" ".h" buffer-file-name))
    (setq h_src (replace-regexp-in-string "/src/" "/include/" h_local))
    (cond
     ((file-exists-p hpp_local) (find-file hpp_local))
     ((file-exists-p hpp_src) (find-file hpp_src))
     ((file-exists-p h_local) (find-file h_local))
     ((file-exists-p h_src) (find-file h_src))
     ))
   (t (message "Did not find match for %s" buffer-file-name))
  ) 
)

(defun switch-header-source ()
  (interactive)
  (switch-hpp-cpp))

(global-set-key (kbd "C-c c") 'switch-header-source)
