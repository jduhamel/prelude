;; Settings for better editing

(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(delete-selection-mode t)
(show-paren-mode t)

;; programming hooks
(add-hook 'prog-mode-hook 'linum-mode)

;; uniq buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-ignore-buffers-re "^\\*")

;;keybindings
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-c +") 'text-scale-increase)
(global-set-key (kbd "C-c -") 'text-scale-decrease)
(global-set-key (kbd "C-.") 'repeat)

;; electric modes
(electric-pair-mode t)
;;(electric-indent-mode t)
;;(electric-layout-mode t)

;; Autocompletion/snippets
(global-set-key (kbd "M-'") 'hippie-expand)

;; Integrate hippie-expand with ya-snippet
;; WriteGood-mode
;(require 'writegood-mode)
;(add-hook 'text-mode-hook 'writegood-turn-on)