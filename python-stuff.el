;;ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport 't)

;; Extend flake8 checker to include pylint also
(flycheck-add-next-checker 'python-flake8 'python-pylint)
(setq flycheck-python-flake8-executable "/Users/eelango/dev/ljenv/bin/flake8")
(setq flycheck-python-pylint-executable "/Users/eelango/dev/ljenv/bin/pylint")

;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flycheck-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flycheck-previous-error)))
;; Shortcut to select a different checker
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cs" 'flycheck-select-checker)))

;; ;; By default it's pyflakes
;; (setq python-check-command "pylint")

(eval-after-load 'flycheck
  '(progn
     (set-face-attribute 'flycheck-error nil
                         :foreground "brightblack"
                         :background "white")
     (set-face-attribute 'flycheck-warning nil
                         :foreground "color-250"
                         :background "brightblack")
     (set-face-attribute 'flycheck-info nil
                         :foreground "color-250"
                         :background "brightblack")
     (setq flycheck-highlighting-mode 'lines)))
