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

;; set up yasnippet
(require 'yasnippet)
(yas/initialize)

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

(autoload 'gofmt-before-save "go-mode" "Add this to .emacs to run gofmt on the current buffer when saving:")
(autoload 'godoc "go-mode" "Show go documentation for a query, much like M-x man")


(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))

(add-hook 'go-mode-hook (lambda ()
                          (auto-complete-mode)
                           (local-set-key (kbd "M-.") 'godef-jump)))

(add-hook 'before-save-hook 'gofmt-before-save)
;;(add-to-list 'load-path "~/gocode/src/github.com/dougm/goflymake")

(require 'go-flymake)

;; ;;;(add-to-list 'load-path "~/gocode/src/github.com/dougm/goflymake")
(require 'go-flycheck)

;; 
;;; personal.el ends here

(add-hook
 'go-mode-hook
 '(lambda ()

    ;; Outline mode

    ;; Level 3: //.  use this to devide the file into major sections
    ;; Level 4: //   followed by at least two characters
    ;; Level 4: package
    ;; Level 4: import
    ;; Level 4: const
    ;; Level 4: var  followed by at least one character
    ;; Level 4: type
    ;; Level 4: func
    ;; Level 5 and above: tab-indented lines with at least five characters
    (make-local-variable 'outline-regexp)
    (setq outline-regexp "//\\.\\|//[^\r\n\f][^\r\n\f]\\|pack\\|func\\|impo\\|cons\\|var[^\r\n\f]\\|type\\|\t\t*[^\r\n\f]\\{4\\}")
    (outline-minor-mode 1)
    (local-set-key "\M-a" 'outline-previous-visible-heading)
    (local-set-key "\M-e" 'outline-next-visible-heading)
    (local-set-key "\C-c\C-c" 'go)

    (setq tab-width 4)
    (setq show-trailing-whitespace t)

    ))


;; helper variable
(defvar hook-go-pkg nil
  "History variable for `go-install-package' and `go-test-package'.")

;; helper function
(defun go ()
  "run current buffer"
  (interactive)
  (compile (concat "go run \"" (buffer-file-name) "\"")))

;; helper function
(defun go-build ()
  "build current buffer"
  (interactive)
  (compile (concat "go build  \"" (buffer-file-name) "\"")))

;; helper function
(defun go-build-dir ()
  "build current directory"
  (interactive)
  (compile "go build ."))


;; Show/hide parts by repeated pressing f10
(add-hook 'outline-minor-mode-hook
           (lambda ()
             (require 'outline-magic)
             (define-key outline-minor-mode-map [(f10)] 'outline-cycle)))
