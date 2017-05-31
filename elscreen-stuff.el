;; Start elscreen
;; (elscreen-start)

;; Name of the first elscreen
;; (elscreen-screen-nickname "dev")

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
  (interactive))
  ;; (open-remote-screen "picrite")
  ;; (open-remote-screen "mainsh250"))

;; Run the init-multi-terms function on startup
;; (add-hook 'emacs-startup-hook 'init-multi-terms)
