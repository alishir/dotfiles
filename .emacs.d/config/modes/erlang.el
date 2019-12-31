(require 'ivy-erlang-complete)
(add-hook 'erlang-mode-hook #'ivy-erlang-complete-init)
;; automatic update completion data after save
(add-hook 'after-save-hook #'ivy-erlang-complete-reparse)

(add-hook 'erlang-mode-hook #'company-erlang-init)

;;(global-set-key "\t" 'ivy-erlang-complete)
