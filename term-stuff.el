;; Set bash as multi-term-program
(setq multi-term-program "/bin/zsh")

;; Use Emacs terminfo, not system terminfo
(setq system-uses-terminfo nil)

;; F5 shortcut to open new multi-term
(global-set-key (kbd "<f5>") 'multi-term)

;; Set term buffer size
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)))

;; Enable transient mark mode in term-line-mode
(defadvice term-line-mode (after term-line-mode-fixes ())
  (set (make-local-variable 'transient-mark-mode) t))
(ad-activate 'term-line-mode)

;; Disable transient mark mode in term-char-mode
(defadvice term-char-mode (after term-char-mode-fixes ())
  (set (make-local-variable 'transient-mark-mode) nil))
(ad-activate 'term-char-mode)

(defun term-send-C-x ()
  "Type C-x in term-mode."
  (interactive)
  (term-send-raw-string "\C-x"))

(defun term-send-C-s ()
  "Type C-s in term-mode."
  (interactive)
  (term-send-raw-string "\C-s"))

(defun term-send-C-c ()
  "Type C-s in term-mode."
  (interactive)
  (term-send-raw-string "\C-c"))

;; Shortcuts for switching between terminals
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
            (add-to-list 'term-bind-key-alist '("C-c C-j" . term-line-mode))
            (add-to-list 'term-bind-key-alist '("C-c C-k" . term-char-mode))
            (add-to-list 'term-bind-key-alist '("C-c C-x" . term-send-C-x))
            (add-to-list 'term-bind-key-alist '("C-c C-s" . term-send-C-s))
            (add-to-list 'term-bind-key-alist '("C-c C-c" . term-send-C-c))))

(defadvice term-handle-ansi-terminal-messages
    (before open-remote-file (message) activate)
  (when (string-match "\eAnSiTx .+\n" message)
    (let* ((start (match-beginning 0))
           (argument
            (save-match-data
              (substring message
                         (+ start 8)
                         (string-match "\r?\n" message
                                       (+ start 8))))))
      ;; Delete this command from MESSAGE.
      (setq message (replace-match "" t t message))
      (save-excursion
        (find-file argument)))))
  
    
;; ;; use utf-8 in ansi-term
;; (defadvice ansi-term (after advise-ansi-term-coding-system)
;;     (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
;; (ad-activate 'ansi-term)

