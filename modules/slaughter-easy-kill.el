;; undo-tree
(slaughter-package-install 'easy-kill)
(require 'easy-kill)

(global-set-key [remap kill-ring-save] 'easy-kill)
(global-set-key [remap mark-sexp] 'easy-mark)

