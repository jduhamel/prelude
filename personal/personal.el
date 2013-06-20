;;; personal.el  --- Personal customization of emacs file
;;; Commentary:
;;; Code:
(setq prelude-guru nil)
;(load-theme 'dark-laptop)

(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

(load-file (expand-file-name "~/.emacs.d/themes/dark-laptop.el"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/personal/python-mode.el-6.0.12"))

(setq py-install-directory (expand-file-name "~/.emacs.d/personal/python-mode.el-6.0.12"))
(require 'python-mode)

(setq py-shell-name "/usr/local/share/python3/ipython3")


(defun toggle-fullscreen ()
  "Toggle fullscreen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
(global-set-key [f11] 'toggle-fullscreen)
(prelude-ensure-module-deps '(go-mode
                              go-autocomplete
                              xml-rpc
                              paredit
                              color-theme
                              deft
                              jira
                              gist
                              pastebin
                              ruby-compilation))

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))

;;; personal.el ends here
