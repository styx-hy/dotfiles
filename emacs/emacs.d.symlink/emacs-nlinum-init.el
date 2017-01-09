(use-package nlinum
  :ensure t
  :config
  (defun initialize-nlinum (&optional frame)
    (setq nlinum-format "%d ")
    (add-hook 'prog-mode-hook (lambda () (nlinum-mode 1)))
    (add-hook 'text-mode-hook (lambda () (message "enable nlinum")(nlinum-mode 1)))
    )
  (defun toggle-nlinum-mode-in-daemon (orig-fun &rest args)
    (progn
      (nlinum-mode -1)
      (apply orig-fun args)
      (nlinum-mode 1)))
  (message "initialize nlinum")
  (if (daemonp)
    (progn
      (add-hook 'window-setup-hook 'initialize-nlinum)
      ;; (advice-add 'make-frame :around #'toggle-nlinum-mode-in-daemon)
      )
    (initialize-nlinum))
  )
