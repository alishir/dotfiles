;; Bidirectional editing
(add-hook 'LaTeX-mode-hook (lambda ()
			     (setq compilation-ask-about-save nil)
			     (setq-default bidi-paragraph-start-re "^")
			     (setq-default bidi-paragraph-separate-re "^")
			     (electric-indent-local-mode -1)
			     (local-set-key [f10] 'recompile)
			     ))
