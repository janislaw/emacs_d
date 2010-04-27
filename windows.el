;;
(defun server-ensure-safe-dir (dir) "Noop" t)
                                        ; Suppress error "directory
                                        ; ~/.emacs.d/server is unsafe"
                                        ; on windows.

(set-default-font "Envy Code R-9")

(setq maximize-or-restore-state 0)

(defun maximize-or-restore ()
  "maximizes or restores"
  (interactive)
  (if (eq maximize-or-restore-state 0)
      (progn (w32-send-sys-command #xf030)
             (setq maximize-or-restore-state 1))
    (progn (w32-send-sys-command #xf120)
           (setq maximize-or-restore-state 0))))

(global-set-key [M-f10] 'maximize-or-restore)

;; cygwin
;; (when (and (= emacs-major-version 23) (equal window-system 'w32))
;;   (setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
;;   (setq exec-path (cons "c:/cygwin/bin/" exec-path))
;;   (require 'cygwin-mount)
;;   (cygwin-mount-activate)

;;   (add-hook 'comint-output-filter-functions
;;             'shell-strip-ctrl-m nil t)
;;   (add-hook 'comint-output-filter-functions
;;             'comint-watch-for-password-prompt nil t)
;;   (setq explicit-shell-file-name "bash.exe")
;;   ;; For subprocesses invoked via the shell
;;   ;; (e.g., "shell -c command")
;;   (setq shell-file-name explicit-shell-file-name)
;; )

;; aspell on windows
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; set yap as viewer under windoze

(setq TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^\\(?:a5\\(?:comb\\|paper\\)\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^\\(?:a5\\(?:comb\\|paper\\)\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "yap -1 %dS %d") ("^pdf$" "." "start acrord32 %o") ("^html?$" "." "start \\\"\\\" %o"))))



