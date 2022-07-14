(slaughter-package-install 'dumb-jump)
(require 'dumb-jump)

(setq dumb-jump-default-project "~/cf/master/cf")
(setq dumb-jump-force-searcher 'rg)
(setq xref-show-definitions-function #'xref-show-definitions-completing-read)
