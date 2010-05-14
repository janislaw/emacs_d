;;
(set-default-font "Monospace-10")

(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; http://www.emacswiki.org/emacs/CopyAndPaste
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)