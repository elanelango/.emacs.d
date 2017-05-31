;; load server if it's not running
(load "server")
(unless (server-running-p) (server-start))

;; hide scroll bar
(if (display-graphic-p)
    (progn
      ;; (tool-bar-mode -1)
      (scroll-bar-mode -1)))

;; column-number-mode always on
(setq column-number-mode t)

;; Better buffer switching using ido-mode
(ido-mode t)

;; Save and restore buffers
(desktop-save-mode 1)

;; Shortcut for rename-buffer
;; TODO: This doesn't work. Why?
(define-key global-map (kbd "M-n") 'rename-buffer)

;; Tab spacing related settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default py-indent-offset 4)

;;Modify the backup files directory
(setq backup-directory-alist '(("." . "~/.saves")))

;; Auto save directory
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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

;; Disables arrow keys in emacs
;; (global-unset-key (kbd "<left>"))
;; (global-unset-key (kbd "<right>"))
;; (global-unset-key (kbd "<up>"))
;; (global-unset-key (kbd "<down>"))
;; (global-unset-key (kbd "<C-left>"))
;; (global-unset-key (kbd "<C-right>"))
;; (global-unset-key (kbd "<C-up>"))
;; (global-unset-key (kbd "<C-down>"))
;; (global-unset-key (kbd "<M-left>"))
;; (global-unset-key (kbd "<M-right>"))
;; (global-unset-key (kbd "<M-up>"))
;; (global-unset-key (kbd "<M-down>"))

;; set tramp default as ssh. Faster than default scp.
(setq tramp-default-method "ssh")

;; Use separate file for customizations added by M-x customize
(setq custom-file "~/.emacs.d/custom.el")
;; load custom-file. Don't complain if the custom-file does not exist
(load custom-file 'noerror)

;; ;; Enable Highlight indendation globally
;; (defun turn-on-highlight-indentation-mode ()
;; (interactive)
;; (highlight-indentation-mode 1))

;; (define-globalized-minor-mode global-highlight-indentation-mode
;;   highlight-indentation-mode turn-on-highlight-indentation-mode)

;; (global-highlight-indentation-mode 1)


(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; Save Tramp files also
(setq desktop-files-not-to-save "^$")

;; re-read stuff from disk
(global-auto-revert-mode t)

;; don't add newline to end
(setq require-final-newline nil)
(setq mode-require-final-newline nil)

