;;; package --- conftest mode is a major mode for editing conftest files

;;; Commentary:

;;; Code:

(defvar conftest-mode-hook nil)


;;;(defvar conftest-mode-map
;;;  (let ((map (make-keymap))) ; consider make-spare-keymap
;;;    (define-key map "\C-j" 'newline-and-indent)
;;;    map)
;;;  "Keymap for conftest major mode.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.conftest\\'" . conftest-mode))

;;; keyword gen:
;;; (kill-new regexp-opt '("group" "test" "config" "should" "pass" "fail" "with") 'words)

(defconst conftest-font-lock-keywords-1
  (list
   '("\\<\\(config\\|fail\\|group\\|pass\\|should\\|test\\|with\\)\\>" 1 'font-lock-keyword-face)
   '("\\(`[^`]*`\\)" 1 'font-lock-string-face prepend) ; expectation strings
   '("^[ \t]*\\([a-z0-9_]+\\)[ \t]+.*{" 1 'font-lock-type-face)
   '("^[ \t]*\\<\\([a-z0-9_]+\\)\\>" 1 'font-lock-variable-name-face)
   '("\\(//.*$\\)" 1 'font-lock-comment-face prepend) ; // comments
   '("\\(/\\*[\0-\377[:nonascii:]]*?\\*/\\)" 1 'font-lock-comment-face prepend) ; /* */ comments
   )
  "Minimal highlighting expressions for conftest mode.")

(defvar conftest-font-lock-keywords conftest-font-lock-keywords-1
  "Default highlighting expressions for conftest mode.")

(defun conftest-mode ()
  "Major mode for editing conftest files."
  (interactive)
  (kill-all-local-variables)
  (set (make-local-variable 'font-lock-defaults) '(conftest-font-lock-keywords))
  (setq major-mode 'conftest-mode)
  (setq mode-name "conftest")
  (prelude-enable-whitespace)
  (run-hooks 'conftest-mode-hook))

(provide 'conftest-mode)

;;; conftest-mode.el ends here
