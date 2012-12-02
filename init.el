(setq el-get-packages
      '(el-get
        pymacs
        ropemacs
        auto-complete
        yasnippet
        python-pep8
        )
      )

;; getelget -- bootstrap el-get if necessary and load the specified packages
(load-file 
 (concat (file-name-as-directory user-emacs-directory) "getelget.el"))

(add-to-list 'load-path "~/.emacs.d")

(setq python-check-command "pyflakes")

;;flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

;;(custom-set-faces
;; '(flymake-errline ((((class color)) (:underline "red"))))
;; '(flymake-warnline ((((class color)) (:underline "yellow")))))

;;ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport 't)

;;; bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda ()
                   (define-key python-mode-map "\C-m" 'newline-and-indent)))

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

;;python-pep8
(require 'python-pep8)

;;python-pylint
;;(require 'python-pylint)

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