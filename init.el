(defalias 'yes-or-no-p 'y-or-n-p)

;; eclipse line moving

;; Move current line up or down with M-up or M-down
(defun move-line (n)
   "Move the current line up or down by N lines."
   (interactive "p")
   (let ((col (current-column))
         start
         end)
     (beginning-of-line)
     (setq start (point))
     (end-of-line)
     (forward-char)
     (setq end (point))
     (let ((line-text (delete-and-extract-region start end)))
       (forward-line n)
       (insert line-text)
       ;; restore point to original column in moved line
       (forward-line -1)
       (forward-char col))))
 
(defun move-line-up (n)
   "Move the current line up by N lines."
   (interactive "p")
   (move-line (if (null n) -1 (- n))))
 
(defun move-line-down (n)
   "Move the current line down by N lines."
   (interactive "p")
   (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; xah-lee

(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the reverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
This command does the reverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end)))

;; python

(setenv "PYTHONUNBUFFERED" "TRUE") ; I like it that way

;; (require 'pycomplete)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
          (lambda ()
            (set (make-variable-buffer-local 'beginning-of-defun-function)
                 'py-beginning-of-def-or-class)
            (setq outline-regexp "def\\|class ")))

;; pymacs

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;; ropemacs
  (defun load-ropemacs ()
    "Load pymacs and ropemacs"
    (interactive)
    (require 'pymacs)
    (pymacs-load "ropemacs" "rope-")
    ;; Automatically save project python buffers before refactorings
    (setq ropemacs-confirm-saving 'nil)
  )


;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; ipython

(setq ipython-command "ipython")
(require 'ipython)


;; end of hand customizations

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))

 '(dict-servers (quote ("localhost")))
;; "dict.org" "alt0.dict.org" "alt1.dict.org" "alt2.dict.org")))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(nxml-bind-meta-tab-to-complete-flag t)
 '(org-export-language-setup (quote (("en" "Author" "Date" "Table of Contents" "Footnotes") ("ca" "Autor" "Data" "&Iacute;ndex" "Peus de p&agrave;gina") ("cs" "Autor" "Datum" "Obsah" "Pozn\341mky pod carou") ("da" "Ophavsmand" "Dato" "Indhold" "Fodnoter") ("de" "Autor" "Datum" "Inhaltsverzeichnis" "Fu&szlig;noten") ("eo" "A&#365;toro" "Dato" "Enhavo" "Piednotoj") ("es" "Autor" "Fecha" "&Iacute;ndice" "Pies de p&aacute;gina") ("fi" "Tekij&auml;" "P&auml;iv&auml;m&auml;&auml;r&auml;" "Sis&auml;llysluettelo" "Alaviitteet") ("fr" "Auteur" "Date" "Table des mati&egrave;res" "Notes de bas de page") ("hu" "Szerz&otilde;" "D&aacute;tum" "Tartalomjegyz&eacute;k" "L&aacute;bjegyzet") ("is" "H&ouml;fundur" "Dagsetning" "Efnisyfirlit" "Aftanm&aacute;lsgreinar") ("it" "Autore" "Data" "Indice" "Note a pi&egrave; di pagina") ("nl" "Auteur" "Datum" "Inhoudsopgave" "Voetnoten") ("no" "Forfatter" "Dato" "Innhold" "Fotnoter") ("nb" "Forfatter" "Dato" "Innhold" "Fotnoter") ("nn" "Forfattar" "Dato" "Innhald" "Fotnotar") ("pl" "Autor" "Data" "Spis treści" "Przypisy") ("sv" "F&ouml;rfattare" "Datum" "Inneh&aring;ll" "Fotnoter"))))
 '(recentf-mode t)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(show-paren-mode t)
 '(tab-width 4)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'dired-find-alternate-file 'disabled nil)

;; CUA
 (setq org-CUA-compatible t)

;; winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; matlab mode
(autoload 'matlab-mode "matlab.el" "Enter Matlab mode." t) 
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist)) 
(autoload 'matlab-shell "matlab.el" "Interactive Matlab mode." t)

(setq matlab-indent-function-body t)  ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 76))		; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; (add-to-list 'exec-path "/opt/matlab/bin")


(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; lua-mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; count words
(defun count-words (&optional begin end) ;; from http://emacs-fu.blogspot.com/2009/01/counting-words.html
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
      (e (if mark-active end (point-max))))
    (message "Word count: %s" (how-many "\\w+" b e))))

;; slick copy/paste
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(autoload 'reftex-mode    "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" t)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
;(add-hook 'latex-mode-hook 'turn-on-reftex)) ; with Emacs latex mode

;(desktop-save-mode 1)
;(add-hook 'auto-save-hook (lambda () (desktop-save-in-desktop-dir)))

(setq load-path (cons "~/.emacs.d" load-path))

(if (equal window-system 'w32)
    (load "windows")
  (load "linux"))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(message "Deleting old backup files...")

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

(load "mymacros")
(load "work")

;; start server

(require 'server)
(server-start)