;; ========================
;; straight package manager
;; ========================
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(require 'use-package)

;; ===============
;; yaml
;; ===============
(straight-use-package 'yaml-mode)

;; ===============
;; helm
;; ===============
(straight-use-package 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

;; ======================
;; lsp-mode
;; ======================
(straight-use-package 'lsp-mode)
(straight-use-package 'helm-lsp)
(straight-use-package 'yasnippet)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'projectile)
(straight-use-package 'hydra)
(straight-use-package 'flycheck)
(straight-use-package 'company)
(straight-use-package 'avy)
(straight-use-package 'which-key)
(straight-use-package 'helm-xref)
(straight-use-package 'dap-mode)

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "C-l")

(use-package lsp-mode
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
            (erlang-mode . lsp)
            ;; if you want which-key integration
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

;; ======================
;; C++
;; ======================
;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1 ;; clangd is fast
      ;; be more ide-ish
      lsp-headerline-breadcrumb-enable t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; ======================
;; Erlang
;; ======================
;; (setq load-path (cons  "/home/ali/.kerl/23.2.1/lib/tools-3.4.2/emacs"
;;		       load-path))
(use-package ivy-erlang-complete
  :straight t
  :ensure t)
(use-package delight
  :straight t
  :ensure t)

(setq erlang-root-dir "/home/ali/.kerl/23.2.1")
(setq exec-path (cons "/home/ali/.kerl/23.2.1/bin" exec-path))
;; (require 'erlang-start)
(use-package erlang
  :load-path ("/home/ali/.kerl/23.2.1/lib/tools-3.4.2/emacs/")
  :hook (after-save . ivy-erlang-complete-reparse)
  :custom (ivy-erlang-complete-erlang-root "/home/ali/.kerl/23.2.1/")
  :config (ivy-erlang-complete-init)
  :mode (("\\.erl?$" . erlang-mode)
	 ("rebar\\.config$" . erlang-mode)
	 ("relx\\.config$" . erlang-mode)
	 ("sys\\.config\\.src$" . erlang-mode)
	 ("sys\\.config$" . erlang-mode)
	 ("\\.config\\.src?$" . erlang-mode)
	 ("\\.config\\.script?$" . erlang-mode)
	 ("\\.hrl?$" . erlang-mode)
	 ("\\.app?$" . erlang-mode)
	 ("\\.app.src?$" . erlang-mode)
	 ("\\Emakefile" . erlang-mode)))


(use-package flycheck
  :straight t
  :ensure t
  :delight
  :config (global-flycheck-mode))

(use-package hydra
  :straight t
  :defer 2
  :bind ("C-c f" . hydra-flycheck/body))
(defhydra hydra-flycheck (:color blue)
  "
  ^
  ^Errors^
  ^──────^
  _<_ previous
  _>_ next
  _l_ list
  _q_ quit
  ^^
  "
  ("q" nil)
  ("<" flycheck-previous-error :color pink)
  (">" flycheck-next-error :color pink)
  ("l" flycheck-list-errors))

;; ======================
;; orgmode
;; ======================
(straight-use-package 'org)

(defun set-bidi-env ()
  "interactive"
  (setq bidi-paragraph-direction 'nil))
(add-hook 'org-mode-hook 'set-bidi-env)
(setq org-agenda-window-setup 'only-window)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;;(require 'org-tempo)

;; ====================
;; general keybindings
;; ====================
;; ALT-space switch back and forth between buffers
(global-set-key (kbd "M-SPC") 'mode-line-other-buffer)
(global-set-key (kbd "<f3>") 'save-buffer)
(global-set-key (kbd "<f12>") 'fill-paragraph)

;; ================
;; auto-complete
;; ================
;; (ac-config-default)
;; (add-hook 'after-init-hook 'global-company-mode)
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

;; =================
;; clang-format
;; =================
(load "/usr/share/emacs/site-lisp/clang-format-11/clang-format.el")
(global-set-key (kbd "<f4>") 'clang-format-buffer)


;; scroll one line at a time (less "jumpy" than defaults)  
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(save-place-mode 1)

;; ============
;; Theme
;; ============
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; =============
;; Font & Face
;; =============
;; This makes emacs slow on arabic files
;; Set default font
(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 110
                    :weight 'normal
                    :width 'normal)

;; Window appearance
;;(when window-system 
(set-fontset-font "fontset-default" '(#x0600 . #x06FF)  "Vazir")
(set-fontset-font "fontset-default" 'unicode  "Vazir")
;;  (set-face-attribute 'default nil :height 120)
;;  )

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; https://emacs.stackexchange.com/questions/3458/how-to-switch-between-windows-quickly
(windmove-default-keybindings)

(add-to-list 'exec-path "/home/ali/bin/")
(setenv "PATH" (concat (getenv "PATH") ":/home/ali/.kerl/23.2.1/bin"))
