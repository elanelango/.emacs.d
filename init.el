;; Packages to include via el-get
(setq el-get-packages
      '(el-get
        pymacs
        ropemacs
        auto-complete
        yasnippet
        flycheck
        xcscope
        xcscope+
        yaml-mode
        org-mode
        )
      )

;; getelget -- bootstrap el-get if necessary and load the specified packages
(load-file 
 (concat (file-name-as-directory user-emacs-directory) "getelget.el"))

;; set theme
(load-theme 'deeper-blue)

;; hide scroll bar
(scroll-bar-mode -1)

;; Remove the line below if removing .emacs.d from loadpath doesn't cause any
;; issues
;; (add-to-list 'load-path "~/.emacs.d")

;; Tab spacing related settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default py-indent-offset 4)

;; Enable extra keys in org-mode. This is to avoid using arrow keys in org-mode
(setq org-use-extra-keys t)

;; column-number-mode always on
(setq column-number-mode t)

;; Better buffer switching using ido-mode
(ido-mode t)

;; Disable transient-mark-mode - Highlighting selection
;; I'm used to transient-mark-mode. So having it enabled.
;; (setq transient-mark-mode nil)

;; Shortcut for rename-buffer
(define-key global-map (kbd "M-n") 'rename-buffer)

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

;; cscope
(require 'xcscope)
(require 'xcscope+)

;;Modify the backup files directory
(setq backup-directory-alist '(("." . "~/.saves")))

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

;; set tramp default as ssh. Faster than default scp.
(setq tramp-default-method "ssh")

;; org-mode settings from org-mode manual
;; not needed when global-font-lock-mode is on
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Disables arrow keys in emacs
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

;; (setq python-check-command "pylint")
