(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-line-column 100)
 '(sp-override-key-bindings (quote (("M-<up>" . nil) ("M-<down>" . nil) ("M-<backspace>" . nil)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; C-a works like normal
(global-set-key [remap move-beginning-of-line]
                'move-beginning-of-line)

;;; C-c C-g -> goto-line
(global-set-key (kbd "C-c C-g") 'goto-line)

;;; M-{up,down} -> scroll-{up,down}-line
(global-set-key (kbd "M-<down>") 'scroll-up-line)
(global-set-key (kbd "M-<up>") 'scroll-down-line)

;;; C-<backspace> -> backword-kill-word
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key (kbd "M-<backspace>") 'backward-kill-word)

;;; Set JS indent to 2 spaces
(set-variable 'js2-basic-offset 2)

;;; STFU
(setq prelude-guru nil)
