;;; personal.el  --- Personal customization of emacs file
;;; Commentary:
;;; Code:

(setq prelude-guru nil)                 ;Set the keys to the arrow-keys

;;; Setup auto-complete and yasnippets
(prelude-ensure-module-deps '(auto-complete))
(prelude-ensure-module-deps '(yasnippet))

;;; Setup Clojure
(prelude-ensure-module-deps '( 4clojure
                               clojure-mode
                               clojure-snippets))

;; Setup go-mode Need to have flymake and snippets setup first due to
;; dependencies

(prelude-ensure-module-deps '(
;;                              go-mode
                              go-autocomplete
                              go-errcheck
                              go-snippets))
;; Setup csharp and fsharp mode
(prelude-ensure-module-deps '(csharp-mode
                              fsharp-mode))

;; Setup flycheck
(prelude-ensure-module-deps '(flycheck))

;; setup Markdown-mode
(prelude-ensure-module-deps '(markdown-mode))

;; Setup outline-magic
(prelude-ensure-module-deps '(outline-magic))

;; Setup Slime
(prelude-ensure-module-deps '(slime))

;; Setup ESS for R mode
(prelude-ensure-module-deps '(ess
                              ess-R-object-popup
                              ess-R-data-view))

;;; Setup Helm
;;(prelude-ensure-module-deps '(helm))

;;(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/")) ; Add the themes to the path.

(load-file (expand-file-name "~/.emacs.d/themes/dark-laptop.el"))



;; Setup
(prelude-ensure-module-deps '(xml-rpc
                              paredit
                              color-theme
                              rvm
                              deft
                              jira
                              gist
                              ruby-end
                              pastebin
                              ruby-compilation))



;;; Setup colors


;(color-theme-initialize)
;(color-theme-dark-laptop)

;; setup python-mode

;; # (add-to-list 'load-path
;; #              (expand-file-name
;; #               "~/.emacs.d/personal/python-mode.el-6.1.2"))
;; # (setq py-install-directory
;; #      (expand-file-name "~/.emacs.d/personal/python-mode.el-6.1.2"))
;; # (require 'python-mode)
;; (setq py-shell-name "/usr/local/share/python3/ipython3")

;; set up yasnippet
(require 'yasnippet)
(require 'go-snippets)

(yas-load-directory "~/.emacs.d/snippets")
(require 'auto-complete)
(require 'go-autocomplete)
(require 'auto-complete-config)


(autoload 'gofmt-before-save
  "go-mode"
  "Add this to .emacs to run gofmt on the current buffer when saving:")
(autoload 'godoc
  "go-mode" "Show go documentation for a query, much like M-x man")
(global-auto-complete-mode)

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))

(add-hook 'go-mode-hook (lambda ()
                          (auto-complete-mode)
                          (local-set-key (kbd "M-.") 'godef-jump)))

(add-hook 'before-save-hook 'gofmt-before-save)

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))


;;(add-to-list 'load-path "~/gocode/src/github.com/dougm/goflymake")

;;(require 'go-flymake)
;(add-to-list 'load-path (expand-file-name "~/go/src/github.com/dougm/goflymake"))
;(require 'go-flycheck)


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
  "History variable for `go-install-package' and `go-test-p
ackage'.")

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

;; Setup Slime

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

                                        ;
;; Put this in your .emacs:
;;              (require 'my-yas-funs)
;;
;; To use in a given major-mode, e.g., js-mode, use:
(add-hook 'go-mode-hook (lambda () (yas-minor-mode-on)))
(add-hook 'go-mode-hook (lambda () (add-to-list 'ac-sources `ac-new-yas-source)))

;;
;; Works best with the following:
(define-key ac-complete-mode-map "\t" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)
(setq yas/trigger-key "TAB")
;;

(require 'yasnippet)

(defvar yas-candidates nil)

(defun init-yas-candidates ()
  (let ((table (yas/get-snippet-tables major-mode)))
    (if table
        (let (candidates (list))
          (mapc (lambda (mode)
                  (maphash (lambda (key value)
                             (push key candidates))
                           (yas-table-hash mode)))
                table)
          (setq yas-candidates candidates)))))



(defvar ac-new-yas-source
  '(    (init . init-yas-candidates)
        (candidates . yas-candidates)
        (action . yas/expand)
        (symbol . "a")))

(provide 'my-yas-funs)

(defun toggle-fullscreen ()
  "Toggle fullscreen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
(global-set-key [f11] 'toggle-fullscreen)

(global-undo-tree-mode -1)

(cd (expand-file-name "~"))
(provide 'personal)
;;; (load-theme 'manoj-dark t)
