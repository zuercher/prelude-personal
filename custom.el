(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (protobuf-mode csv-mode cmake-mode zop-to-char zenburn-theme yari yaml-mode volatile-highlights vkill undo-tree smex smartrep smartparens smart-mode-line scala-mode2 ruby-tools rainbow-mode rainbow-delimiters ox-gfm ov operate-on-number move-text markdown-mode magit json-mode js2-mode inf-ruby ido-ubiquitous guru-mode grizzl gotest god-mode go-projectile gitignore-mode gitconfig-mode git-timemachine gist flycheck flx-ido expand-region exec-path-from-shell elisp-slime-nav easy-kill dockerfile-mode discover-my-major diminish diff-hl company-go browse-kill-ring beacon anzu ace-window)))
 '(sp-override-key-bindings (quote (("M-<up>") ("M-<down>") ("M-<backspace>"))))
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

;;; M-{up,down} -> scroll-{up,down}-line
(global-set-key (kbd "M-<down>") 'scroll-up-line)
(global-set-key (kbd "M-<up>") 'scroll-down-line)

;;; C-<backspace> -> backword-kill-word
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key (kbd "M-<backspace>") 'backward-kill-word)

;;; Set JS indent to 2 spaces
(set-variable 'js2-basic-offset 2)

;;; Could not get .dir-locals.el to work, so cribbed this from:
;;; https://emacs.stackexchange.com/questions/2/different-indentation-styles-for-different-projects
(defvar zuercher-guessed-project nil)
(make-variable-buffer-local 'zuercher-guessed-project)
(defun zuercher-guess-project-from-file-name ()
  (save-match-data
    (setq zuercher-guessed-project
          (cond
           ((string-match "/envoy/" buffer-file-name)
            'google)
           ((string-match "/turbinelabs-envoy/" buffer-file-name)
            'google)
           (t 'default)
           ))))

(defun zuercher-c-mode-common-defaults ()
  (zuercher-guess-project-from-file-name)
  (pcase zuercher-guessed-project
   ('google (c-set-style "google"))
   ('default (c-set-style "gnu")
     (setq c-basic-offset 2)
     (c-set-offset 'substatement-open 0))
   ))

(defun zuercher-go-mode-defaults ()
  (setq tab-width 4))


(setq prelude-c-mode-common-hook 'zuercher-c-mode-common-defaults)

(add-hook 'prelude-go-mode-hook 'zuercher-go-mode-defaults)

;;; STFU
(setq prelude-guru nil)
