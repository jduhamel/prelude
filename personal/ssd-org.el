;; org-mode settings
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t
      org-agenda-files '("~/org/"
                         "~/org/deft"))

;; use MobileOrg for syncing and
;; mobile access
(setq org-mobile-directory "~/Dropbox/MobileOrg")
;(org-mobile-pull)

;; This is currently a bit too slow to be useful
;;(add-hook 'after-save-hook 'org-mobile-push-on-save)
;;(add-hook 'org-mode-hook 'org-mobile-pull)

(defun org-mobile-push-on-save ()
  "Sync on Save for OrgMode buffers"
  (if (eq major-mode 'org-mode)
      (org-mobile-push)))

;; org-capture
;; to quickly capture new tasks
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n")
        ("p" "Project" entry (file+headline "~/org/gtd.org" "Projects")
         "* %?\n %i\n")))

;; refile targets for cleaning up collection
(setq org-refile-targets (quote ((nil :maxlevel . 2)
                                 (org-agenda-files :maxlevel . 3)))
      org-refile-allow-creating-parent-node t)


;; deft for quick note taking and project planning
(require 'deft)
(setq deft-extension "org"
      deft-directory "~/org/deft/"
      deft-text-mode 'org-mode
      deft-auto-save-interval 30.0)
(global-set-key (kbd "\C-cd") 'deft)
