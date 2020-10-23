(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(org-agenda-files (quote ("~/projects/_todo_/todo.org")))
 '(package-selected-packages
   (quote
    (rust-mode org org-multiple-keymap openwith vue-mode rjsx-mode rfc-mode smooth-scrolling company-erlang ivy-erlang-complete elixir-mode hl-todo erlang auto-complete auctex evil zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when window-system 
  (set-fontset-font "fontset-default" 'unicode  "Vazir Code")
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (toggle-scroll-bar -1)
  (tooltip-mode -1))
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(display-time-mode 1)
(global-display-line-numbers-mode)
(set-default 'truncate-lines t)

;; set vim mode
(require 'evil)
(evil-mode t)

;; set ido mode
(require 'ido)
(ido-mode t)

;; auto-complete
;;(ac-config-default)
;;(add-hook 'after-init-hook 'global-company-mode)
;; disable auto-complete
(auto-complete-mode -1)

;; theme
(load-theme 'zenburn t)
(smooth-scrolling-mode t)

;; use space instead of tab for indentation
(setq-default indent-tabs-mode nil)

;; Set default font
(set-face-attribute 'default nil
                    :family "SauceCodePro Nerd Font Mono"
                    :height 120
                    :weight 'normal
                    :width 'normal)
;; open PDF files with MuPDF
(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "mupdf" (file))))

;; remote editing
(require 'tramp)
(setq tramp-default-method "scp")

;; ALT-space switch back and forth between buffers
(global-set-key (kbd "M-SPC") 'mode-line-other-buffer)
(global-set-key (kbd "<f3>") 'save-buffer)



(load "~/.emacs.d/load-directory")
(load-directory "~/.emacs.d/config")

