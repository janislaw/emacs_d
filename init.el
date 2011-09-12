;; dired
(put 'dired-find-alternate-file 'disabled nil)

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

;; custom

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(dict-servers (quote ("localhost")))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
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
 '(trailing-whitespace ((((class color) (background light)) nil))))

;; CUA
 (setq org-CUA-compatible t)

;; winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; lua-mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

  ;If you want colorization, turn on global-font-lock or add this:
(add-hook 'lua-mode-hook 'turn-on-font-lock)

  ;If you want to use hideshow, turn on hs-minor-mode or add this:
(add-hook 'lua-mode-hook 'hs-minor-mode)

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


;; at last:

(toggle-uniquify-buffer-names)

(defun gtfo ()
  "Remove friendly decorations"
  (interactive)
  (menu-bar-mode -1)
  (when window-system
    (tool-bar-mode -1))
  (scroll-bar-mode -1))


(defun cpp-guard ()
  (interactive)
  (if (buffer-file-name)
      (let*
          ((fName (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))))
           (ifDef (concat "#ifndef " fName "_H" "\n#define " fName "_H" "\n"))
           (begin (point-marker)))
        (progn ; If less then 5 characters are in the buffer, insert the class definition
          (if (< (- (point-max) (point-min)) 5 )
              (progn
                (insert "\nclass " (capitalize fName) "{\npublic:\n\nprivate:\n\n};\n")
                (goto-char (point-min))
                (next-line-nomark 3)
                (setq begin (point-marker))))
                                        ;Insert the Header Guard
          (goto-char (point-min))
          (insert ifDef)
          (goto-char (point-max))
          (insert "\n#endif" " //" fName "_H")
          (goto-char begin)))
                                        ;else
    (message (concat "Buffer " (buffer-name) " must have a filename"))))

(global-linum-mode 1)

;;

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq load-path (cons "~/.emacs.d" load-path))
(setq load-path (cons "~/.emacs.d/local" load-path))

(if (equal window-system 'w32)
    (load "windows")
  (load "linux"))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(message "Deleting old backup files...")

(load "line-moving")
(load "python-setup")
(load "history-setup")
(load "mymacros")
(load "work")

;; start server in the end

(require 'server)
(server-start)
