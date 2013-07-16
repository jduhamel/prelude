;;; personal.el  --- Personal customization of emacs file
;;; Commentary:
;;; Code:
(setq prelude-guru nil)
;(load-theme 'dark-laptop)

(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

(load-file (expand-file-name "~/.emacs.d/themes/dark-laptop.el"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/personal/python-mode.el-6.1.1"))

(setq py-install-directory (expand-file-name "~/.emacs.d/personal/python-mode.el-6.1.1"))

(require 'python-mode)

;; (setq py-shell-name "/usr/local/share/python3/ipython3")


(defun toggle-fullscreen ()
  "Toggle fullscreen"
  (interactive)
  (set-frame-parameter
    nil 'fullscreen
    (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
 (global-set-key [f11] 'toggle-fullscreen)
 (prelude-ensure-module-deps '(go-mode
                               go-autocomplete
                               auto-complete
                               xml-rpc
                               paredit
                               color-theme
                               rvm
                               deft
                               jira
                               gist
                               ruby-end
                               pastebin
                               ruby-compilation))

(require 'go-autocomplete)
(require 'auto-complete-config)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))

(add-hook 'go-mode-hook (lambda ()
                           (local-set-key (kbd "M-.") 'godef-jump)))
;;(add-to-list 'load-path "~/gocode/src/github.com/dougm/goflymake")
(require 'go-flymake)


;; ;;;(add-to-list 'load-path "~/gocode/src/github.com/dougm/goflymake")
(require 'go-flycheck)

;; 
;;; personal.el ends here
