
(defmacro fifth (a) `(car  (cdr (cdr (cdr (cdr ,a))))))

(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message file)
      (delete-file file))))

;; save history between sessions
(setq savehist-additional-variables    ;; also save...
  '(search-ring regexp-search-ring compile-history)    ;; search and history
  savehist-file "~/.emacs.d/savehist") ;; where to save
(savehist-mode t)                      ;; do customization before activate
