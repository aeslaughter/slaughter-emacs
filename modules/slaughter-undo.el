;; undo-tree
(slaughter-package-install 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode)

(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-visualizer-diff t)

(defun undo-tree-visualizer-update-linum (&rest args)
    (linum-update undo-tree-visualizer-parent-buffer))
(advice-add 'undo-tree-visualize-undo :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualize-redo :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualize-undo-to-x :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualize-redo-to-x :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualizer-mouse-set :after #'undo-tree-visualizer-update-linum)
(advice-add 'undo-tree-visualizer-set :after #'undo-tree-visualizer-update-linum)

;; KEYBINDINGS
(define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)



