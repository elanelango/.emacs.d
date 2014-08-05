(setq el-get-packages
      '(el-get
        pymacs
        ropemacs
        auto-complete
        yasnippet
        flycheck
        )
      )

;; getelget -- bootstrap el-get if necessary and load the specified packages
(load-file 
 (concat (file-name-as-directory user-emacs-directory) "getelget.el"))

(add-to-list 'load-path "~/.emacs.d")

;; Tab spacing related settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default py-indent-offset 4)

;;ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport 't)

;;auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
(ac-config-default)
(require 'auto-complete)
(global-auto-complete-mode t)

;;yasnippet
(require 'yasnippet)

;; enable flycheck
(require 'flycheck)
;; Enable flycheck globally
(add-hook 'after-init-hook #'global-flycheck-mode)
;; Extend flake8 checker to include pylint also
(flycheck-add-next-checker 'python-flake8 'python-pylint)
;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flycheck-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flycheck-previous-error)))
;; Shortcut to select a different checker
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cs" 'flycheck-select-checker)))

;;Modify the backup files directory
(setq backup-directory-alist '(("." . "/home/eelango/.saves")))

;;There are a number of arcane details associated with how Emacs might
;;create your backup files. Should it rename the original and write out
;;the edited buffer? What if the original is linked?
;;In general, the safest but slowest bet is to always make backups by copying.
(setq backup-by-copying t)

;;do more backups
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((require-final-newline . t) (whitespace-style face trailing lines-tail) (whitespace-line-column . 80)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )



;; Things that might be useful later.
;; (global-set-key [f10] 'flymake-goto-prev-error)
;; (global-set-key [f11] 'flymake-goto-next-error)

;; ;; bind RET to py-newline-and-indent
;; (add-hook 'python-mode-hook '(lambda ()
;;                    (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; (setq python-check-command "pylint")
