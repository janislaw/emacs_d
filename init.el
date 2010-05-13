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

;; start server

(require 'server)
(server-start)

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

;(setq ipython-command "C:\\Python26\\Scripts\\ipython")
;(require 'ipython)


;; end of hand customizations

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(recentf-mode t)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(tab-width 4)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'dired-find-alternate-file 'disabled nil)

;; spice-mode

(autoload 'spice-mode "spice-mode" "Spice/Layla Editing Mode" t)
(setq auto-mode-alist (append (list (cons "\\.sp$" 'spice-mode)
				       (cons "\\.cir$" 'spice-mode)
				       (cons "\\.ckt$" 'spice-mode)
				       (cons "\\.mod$" 'spice-mode)
				       (cons "\\.cdl$" 'spice-mode)
				       (cons "\\.chi$" 'spice-mode) ;eldo outpt
				       (cons "\\.inp$" 'spice-mode))
				 auto-mode-alist))

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

;; my macros
(fset 'c-include
   [?# ?i ?n ?c ?l ?u ?d ?e ?  ?< ?> left])
(fset 'c-main
   [?i ?n ?t ?  ?m ?a ?i ?n ?\( ?i ?n ?t ?  ?a ?r ?g ?c ?, ?  ?c ?h ?a ?r ?* ?  ?a ?r ?g ?v ?\[ ?\] ?\) ?\{ return return ?\} up tab ?r ?e ?t ?u ?r ?n ?  ?0 ?\; up end return tab])
(fset 'py-main
   [?# ?! ?/ ?u ?s ?r ?/ ?b ?i ?n ?/ ?p ?y ?t ?h ?o ?n return ?# ?  ?- ?* ?- ?  ?c ?o ?d ?i ?n ?g ?: ?  ?u ?t ?f ?- ?8 ?  ?- ?* ?- return return ?d ?e ?f ?  ?m ?a ?i ?n ?\( ?\) ?: return ?p ?a ?s ?s return return ?i ?f ?  ?_ ?_ ?n ?a ?m ?e ?_ ?_ ?  ?= ?= ?  ?\' ?_ ?_ ?m ?a ?i ?n ?_ ?_ ?\' ?: return ?m ?a ?i ?n ?\( ?\) return backspace])
(fset 'c-stdio
   "#include <stdio.h>")
(fset 'milestones
   [?\C-\M-% ?\[ ?\[ ?: ?d ?i ?g ?i ?t ?: ?\] ?\] ?  left left left left left left left left left left left left ?\\ ?\( right right right right right right right right right right right ?\\ ?\) right return ?\\ ?1 ?\C-q tab return ?! C-home ?\M-% ?  ?\( return ?\C-q tab return ?! C-home ?\M-% ?\) return return ?!])

(setenv "PYTHONPATH" "/home/janislaw/projekty/bag:/home/janislaw/projekty/sslcacmbotohl")
;(setenv "PATH" (concat "D:\\projekty\\bag;" (getenv "PATH")))

(setq load-path (cons "~/.emacs.d" load-path))

(if (equal window-system 'w32)
    (load "windows")
  (load "linux"))
