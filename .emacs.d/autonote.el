;;; autonote --- auto inserte primary buffer to org file
;;; Commentary:

;;; Code:
(defun get-primary ()
  (setq new-primary (ignore-errors (gui-get-primary-selection)))
  (when (eq major-mode 'org-mode)
    (unless (minibufferp)
      (unless (equal old-primary new-primary)
	(message "set new primary")
	(setq primary-fixed-broken (replace-regexp-in-string "-\n" "" new-primary))
	(insert (replace-regexp-in-string "\n" " " primary-fixed-broken))

	(fill-paragraph)
	(setq old-primary new-primary)
	(org-meta-return)
	)
      )
    )
  )


(defun start-auto-noting ()
  (interactive)
  ;; stop previouse timer
  (when (boundp 'autonote-timer) (stop-auto-noting))
  ;(setq new-primary '"")
  ;(setq old-primary '"")
  (setq new-primary (ignore-errors (gui-get-primary-selection)))
  (setq old-primary new-primary)
  (setq autonote-timer (run-with-timer 0 1 'get-primary))
  
  (message "starting auto noting ...")
  )
(defun stop-auto-noting ()
  (interactive)
  (cancel-timer autonote-timer)
  (message "stoping auto noting ...")
  )
