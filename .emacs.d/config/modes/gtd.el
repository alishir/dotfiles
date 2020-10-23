(setq org-agenda-files '("~/projects/_gtd/inbox.org"
                         "~/projects/_gtd/gtd.org"
                         "~/projects/_gtd/tickler.org"))



(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/projects/_gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/projects/_gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))


(setq org-refile-targets '(("~/projects/_gtd/gtd.org" :maxlevel . 3)
                           ("~/projects/_gtd/someday.org" :level . 1)
                           ("~/projects/_gtd/tickler.org" :maxlevel . 2)))


(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-custom-commands 
      '(("w" "At the office" tags-todo "@work"
         ((org-agenda-overriding-header "work")
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


