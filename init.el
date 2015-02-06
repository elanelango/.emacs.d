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
        )
      )

;; getelget -- bootstrap el-get if necessary and load the specified packages
(load-file 
 (concat (file-name-as-directory user-emacs-directory) "getelget.el"))

;; Use separate file for customizations added by M-x customize
(setq custom-file "~/.emacs.d/custom.el")
;; load custom-file. Don't complain if the custom-file does not exist
(load custom-file 'noerror)

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

;; Save and restore buffers
(desktop-save-mode 1)

;; Shortcut for rename-buffer
;; TODO: This doesn't work. Why?
(define-key global-map (kbd "M-n") 'rename-buffer)

;; Set bash as multi-term-program
(setq multi-term-program "/bin/bash")

;; F5 shortcut to open new multi-term
(global-set-key (kbd "<f5>") 'multi-term)

;; Set multi-term's buffer size
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)))

(defun term-send-C-x ()
  "Type C-x in term-mode."
  (interactive)
  (term-send-raw-string "\C-x"))

(defun term-send-C-s ()
  "Type C-s in term-mode."
  (interactive)
  (term-send-raw-string "\C-s"))

;; Shortcuts for switching between terminals
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
            (add-to-list 'term-bind-key-alist '("C-c C-j" . term-line-mode))
            (add-to-list 'term-bind-key-alist '("C-c C-k" . term-char-mode))
            (add-to-list 'term-bind-key-alist '("C-c C-x" . term-send-C-x))
            (add-to-list 'term-bind-key-alist '("C-c C-s" . term-send-C-s))))

(when (require 'term nil t)
  (defun term-handle-ansi-terminal-messages (message)
    (while (string-match "\eAnSiT.+\n" message)
      ;; Extract the command code and the argument.
      (let* ((start (match-beginning 0))
             (command-code (aref message (+ start 6)))
             (argument
              (save-match-data
                (substring message
                           (+ start 8)
                           (string-match "\r?\n" message
                                         (+ start 8))))))
        ;; Delete this command from MESSAGE.
        (setq message (replace-match "" t t message))

        (cond ((= command-code ?c)
               (setq term-ansi-at-dir argument))
              ((= command-code ?h)
               (setq term-ansi-at-host argument))
              ((= command-code ?u)
               (setq term-ansi-at-user argument))
              ((= command-code ?e)
               (save-excursion
                 (find-file-other-window argument)))
              ((= command-code ?x)
               (save-excursion
                 (find-file argument))))))

    (when (and term-ansi-at-host term-ansi-at-dir term-ansi-at-user)
      (setq buffer-file-name
            (format "%s@%s:%s" term-ansi-at-user term-ansi-at-host term-ansi-at-dir))
      (set-buffer-modified-p nil)
      (setq default-directory (if (string= term-ansi-at-host (system-name))
                                  (concatenate 'string term-ansi-at-dir "/")
                                (format "/%s@%s:%s/" term-ansi-at-user term-ansi-at-host term-ansi-at-dir))))
    message))

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

;; Start elscreen
(elscreen-start)

;; Name of the first elscreen
(elscreen-screen-nickname "dev")

;; function that creates a elscreen, renames the screen, opens multiterm
;; ssh to remote server and opens a screen with the specified name in the
;; remote server.
(defun open-remote-screen (term-name)
  (let* ((mt-buffer-name "*terminal<1>*")
         (term-process (get-buffer-process mt-buffer-name)))
    (elscreen-create)
    (elscreen-screen-nickname term-name)
    (multi-term)
    (comint-send-string term-process "ssh picrite\n")
    (comint-send-string term-process (concat "screen -dr " term-name "\n"))
    (with-current-buffer mt-buffer-name
      (rename-buffer term-name))))

;; Open a bunch of elscreens with multiterms
(defun init-multi-terms ()
  (interactive)
  (open-remote-screen "picrite")
  (open-remote-screen "mainsh250"))

;; Run the init-multi-terms function on startup
(add-hook 'emacs-startup-hook 'init-multi-terms)
