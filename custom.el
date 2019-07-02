(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (erlang scala-mode thrift go-mode php-mode protobuf-mode csv-mode cmake-mode zop-to-char zenburn-theme yari yaml-mode volatile-highlights vkill undo-tree smex smartrep smartparens smart-mode-line scala-mode2 ruby-tools rainbow-mode rainbow-delimiters ox-gfm ov operate-on-number move-text markdown-mode magit json-mode js2-mode inf-ruby ido-ubiquitous guru-mode grizzl gotest god-mode go-projectile gitignore-mode gitconfig-mode git-timemachine gist flycheck flx-ido expand-region exec-path-from-shell elisp-slime-nav easy-kill dockerfile-mode discover-my-major diminish diff-hl company-go browse-kill-ring beacon anzu ace-window)))
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
           ((string-match "/slack-envoy/" buffer-file-name)
            'google)
           (t 'default)
           ))))

;;; c-mode
(defun zuercher-c-mode-common-defaults ()
  ;; My custom install of cc-mode 5.33 does not derive from prog-mode
  ;; (this may change when it lands in the emacs release). For now,
  ;; run prelude-prog-mode defaults so I get my smart parens and
  ;; whitespace highlighting.
  (prelude-prog-mode-defaults)

  (c-subword-mode)

  (zuercher-guess-project-from-file-name)
  (pcase zuercher-guessed-project
   ('google (c-set-style "google"))
   ('default (c-set-style "gnu")
     (setq c-basic-offset 2)
     (c-set-offset 'substatement-open 0))
   ))

(setq prelude-c-mode-common-hook 'zuercher-c-mode-common-defaults)

;;; go-mode
(defun zuercher-go-mode-defaults ()
  (setq tab-width 4)
  (setq truncate-lines t)
  (local-set-key (kbd "M-.") 'godef-jump))


(add-hook 'prelude-go-mode-hook 'zuercher-go-mode-defaults)

;;; php-mode

;; Cribbed from google-c-style
;; Wrapper function needed for Emacs 21 and XEmacs (Emacs 22 offers the more
;; elegant solution of composing a list of lineup functions or quantities with
;; operators such as "add")
(defun zuercher-php-lineup-expression-plus-4 (langelem)
  "Indent to the beginning of the current PHP expression plus 4 spaces.
Suitable for inclusion in `c-offsets-alist'."
  (save-excursion
    (back-to-indentation)
    ;; Go to beginning of *previous* line:
    (c-backward-syntactic-ws)
    (back-to-indentation)
    ;(cond
    ; ;; We are making a reasonable assumption that if there is a control
    ; ;; structure to indent past, it has to be at the beginning of the line.
    ; ((looking-at "\\(\\(if\\|for\\|while\\)\\s *(\\)")
    ;  (goto-char (match-end 1)))
    ; ;; For constructor initializer lists, the reference point for line-up is
    ; ;; the token after the initial colon.
    ; ((looking-at ":\\s *")
    ;  (goto-char (match-end 0))))
    (vector (+ 4 (current-column)))))

(defconst zuercher-php-style
  '((c-basic-offset . 4)
    (c-offsets-alist . ((arglist-intro zuercher-php-lineup-expression-plus-4)
                        (arglist-close . 0)
                        (brace-list-intro . +)))
    ))

(defun zuercher-php-mode-defaults ()
  "Personal PHP mode defaults."
  (whitespace-toggle-options '(tabs))
  (c-add-style "Slack PHP" zuercher-php-style t))

(add-hook 'php-mode-hook 'zuercher-php-mode-defaults)

;;; python
(defun zuercher-python-mode-defaults ()
  "Personal Python mode defaults."
  (python-indent-guess-indent-offset))

(add-hook 'prelude-python-mode-hook 'zuercher-python-mode-defaults)

;;; disable ido filename guess based on the current point
(setq ido-use-filename-at-point nil)

;;; STFU with the hints
(setq prelude-guru nil)
