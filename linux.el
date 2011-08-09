;;
(set-default-font "Monospace-10")

(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-list-command "list")

;; http://www.emacswiki.org/emacs/CopyAndPaste
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(setq temporary-file-directory "~/.emacsbackups")

(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
(setq TeX-view-program-selection '((output-pdf "Evince")))
