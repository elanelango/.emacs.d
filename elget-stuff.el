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
        multi-term
        elscreen
        highlight-indentation
        color-theme-zenburn
        atom-dark-theme
        )
      )

;; getelget -- bootstrap el-get if necessary and load the specified packages
(load-file 
 (concat (file-name-as-directory user-emacs-directory) "getelget.el"))

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

;; cscope
(require 'xcscope)
(require 'xcscope+)
