 (defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "elget-stuff.el")
(load-user-file "emacs-stuff.el")
(load-user-file "org-stuff.el")
(load-user-file "term-stuff.el")
(load-user-file "elscreen-stuff.el")
(load-user-file "python-stuff.el")
(load-user-file "perl-stuff.el")
;; (load-user-file "ee-mu4e.el")
