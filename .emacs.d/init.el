(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (erlang auto-complete auctex evil zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when window-system 
  (set-fontset-font "fontset-default" 'unicode  "Noto Sans Arabic")
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(menu-bar-mode -1)
(display-time-mode 1)

;; set vim mode
(require 'evil)
(evil-mode t)

;; set ido mode
(require 'ido)
(ido-mode t)

;; auto-complete
(ac-config-default)
(add-hook 'after-init-hook 'global-company-mode)

(load "~/.emacs.d/load-directory")
(load-directory "~/.emacs.d/config")

