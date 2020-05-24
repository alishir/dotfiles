(setq load-path (cons  "/home/ali/.kerl/22.2/lib/tools-3.3/emacs/" load-path))
(setq erlang-root-dir "/home/ali/.kerl/22.2/")
(setq exec-path (cons "/home/ali/.kerl/22.2/bin/" exec-path))
(require 'erlang-start)

(add-to-list 'auto-mode-alist '("rebar.config" . erlang-mode)) ;; rebar

;; space only indentation
(setq erlang-mode-hook
      (function (lambda ()
                  (setq indent-tabs-mode nil))))

