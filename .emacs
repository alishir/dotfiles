(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t)
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "mupdf %s"))))
 '(package-selected-packages
   (quote
    (ranger evil-org markdown-mode auto-complete flycheck-tip flycheck company popup magit circe evil-visual-mark-mode zenburn-theme org)))
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3F3F3F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "DAMA" :family "Noto Sans Mono")))))

(load-theme 'zenburn t)
(when window-system 
  (set-fontset-font "fontset-default" 'unicode  "Noto Sans Arabic")
  ;(set-fontset-font "fontset-default" '(#x600 . #x6ff) "DejaVu Sans Mono") 
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(menu-bar-mode -1)

;; enable ido mode
(ido-mode t)
(global-linum-mode t)
(setq backup-inhibited t)

;; set vim mode
(require 'evil)
(evil-mode t)

;; auto-complete
(ac-config-default)
(add-hook 'after-init-hook 'global-company-mode)


;; erlang config
(setq load-path (cons "/usr/local/lib/erlang/lib/tools-3.1/emacs" load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;;flycheck
(require 'flycheck)
(flycheck-define-checker erlang-otp
  "An Erlang syntax checker using the Erlang interpreter."
  :command ("erlc" "-o" temporary-directory "-Wall"
	    "-I" "../include" "-I" "../../include"
	    "-I" "../../../include" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ": Warning:" (message) line-end)
   (error line-start (file-name) ":" line ": " (message) line-end))
  :modes (erlang-mode)
  )
(add-hook 'erlang-mode-hook
	  (lambda ()
	    (flycheck-select-checker 'erlang-otp)
	    (flycheck-mode)))
(require 'flycheck-tip)
(flycheck-tip-use-timer 'verbose)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; toggle between most recent buffers                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://www.emacswiki.org/emacs/SwitchingBuffers#toc5
(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
;; set key binding
(global-set-key (kbd "M-SPC") 'switch-to-previous-buffer)
(global-set-key (kbd "M-y") 'clipboard-yank)

;; evil-org-mode
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

;; org-mode GTD
(define-key global-map "\C-ca" #'org-agenda)
(define-key global-map "\C-cc" #'org-capture)

(setq org-agenda-files '("~/gtd/inbox.org"
			 "~/gtd/gtd.org"
			 "~/gtd/tickler.org"))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
			       (file+headline "~/gtd/inbox.org" "Tasks")
			       "* TODO %i%? [%]")
			      ("T" "Tickler" entry
			       (file+headline "~/gtd/tickler.org" "Tickler")
			       "* %i%? \nSCHEDULED: %^t")))
(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
			   ("~/gtd/someday.org" :level . 1)
			   ("~/gtd/tickler.org" :maxlevel . 2)))
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@reading"
	 ((org-agenda-overriding-header "Office")
	  (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
	(when (org-current-is-todo)
	  (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
	  (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))


;; C code style
(setq c-default-style "k&r")

(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if succeeded without warnings "
  (when (and
	 (buffer-live-p buffer)
	 (string-match "compilation" (buffer-name buffer))
	 (string-match "finished" string)
	 (not
	  (with-current-buffer buffer
	    (goto-char (point-min))
	    (search-forward "warning" nil t))))
    (run-with-timer 1 nil
		    (lambda (buf)
		      (bury-buffer buf)
		      (switch-to-prev-buffer (get-buffer-window buf) 'kill))
		    buffer)))

;; Bidirectional editing
(add-hook 'latex-mode-hook (lambda ()
			     (setq compilation-ask-about-save nil)
			     (setq-default bidi-paragraph-start-re "^")
			     (setq-default bidi-paragraph-separate-re "^")
			     (electric-indent-local-mode -1)
			     (local-set-key [f10] 'recompile)
			     ))
