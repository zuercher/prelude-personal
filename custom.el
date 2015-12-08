(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-line-column 100))
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

;;; S-{up,down} -> scroll-{up,down}-line
;;; NOTE: I wanted this to be M-up/down, but I cannot get prelude's
;;; smartparens init to not override those.
(global-set-key (kbd "S-<up>") 'scroll-up-line)
(global-set-key (kbd "S-<down>") 'scroll-down-line)
