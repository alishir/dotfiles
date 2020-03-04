(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (vue-mode rjsx-mode rfc-mode smooth-scrolling company-erlang ivy-erlang-complete elixir-mode hl-todo erlang auto-complete auctex evil zenburn-theme))))
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
  (tooltip-mode -1))
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(menu-bar-mode -1)
(display-time-mode 1)
(linum-mode 1)

;; set vim mode
(require 'evil)
(evil-mode t)

;; set ido mode
(require 'ido)
(ido-mode t)

;; auto-complete
(ac-config-default)
(add-hook 'after-init-hook 'global-company-mode)

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

(load "~/.emacs.d/load-directory")
(load-directory "~/.emacs.d/config")

