; These are my minor ido tweaks

(ido-mode t)
; write-file should not complete
(define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)
(defun caar (x) (car (car x)))
(defun cadr (x) (car (cdr x)))
(defun cdar (x) (cdr (car x)))
(defun cddr (x) (cdr (cdr x)))
(defun caaar (x) (car (car (car x))))
(defun caadr (x) (car (car (cdr x))))
(defun cadar (x) (car (cdr (car x))))
(defun caddr (x) (car (cdr (cdr x))))
(defun cdaar (x) (cdr (car (car x))))
(defun cdadr (x) (cdr (car (cdr x))))
(defun cddar (x) (cdr (cdr (car x))))
(defun cdddr (x) (cdr (cdr (cdr x))))

(defun first (l) (car l))
(defun second (l) (first (cdr l)))
(defun third (l) (second (cdr l)))
(defun fourth (l) (third (cdr l)))
(defun fifth (l) (fourth (cdr l)))
(defun sixth (l) (fifth (cdr l)))
(defun seventh (l) (sixth (cdr l)))
(defun eighth (l) (seventh (cdr l)))
(defun ninth (l) (eighth (cdr l)))
(defun tenth (l) (ninth (cdr l)))
;configure ido
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file (concat prelude-savefile-dir "ido.hist")
      ido-default-file-method 'selected-window)

; not exactly ido, but hey
(icomplete-mode +1)
(set-default 'imenu-auto-rescan t)

; Sort by mtime (from emacs wiki)
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)


(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list
              (lambda (a b)
                (time-less-p
                 (sixth (file-attributes (concat ido-current-directory b)))
                 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))
