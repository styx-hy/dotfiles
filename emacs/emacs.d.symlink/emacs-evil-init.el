;;; ** evil

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)

  ;;; *** evil-leader
  ;; should set before enable evil-mode
  ;; Vim key bindings
  (use-package evil-leader
    :ensure t
    :config
    (evil-leader/set-leader ",")
    (evil-leader/set-key
     "ci" 'evilnc-comment-or-uncomment-lines
     "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
     "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
     "cc" 'evilnc-copy-and-comment-lines
     "cp" 'evilnc-comment-or-uncomment-paragraphs
     "cr" 'comment-or-uncomment-region
     "cv" 'evilnc-toggle-invert-comment-line-by-line
     "\\" 'evilnc-comment-operator) ; if you prefer backslash key
    (global-evil-leader-mode))

  ;; change color in different state
  (require 'cl)
  (lexical-let ((default-color (cons (face-background 'mode-line)
  				     (face-foreground 'mode-line))))
    (add-hook 'post-command-hook
  	      (lambda ()
  		(let ((color (cond ((minibufferp) default-color)
  				   ((evil-insert-state-p) '("#e80000" . "#ffffff"))
  				   ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
  				   ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
  				   (t default-color))))
  		  (set-face-background 'mode-line (car color))
  		  (set-face-foreground 'mode-line (cdr color))))))

  (defun evil-search-symbol (forward)
    "Search for symbol near point. If FORWARD is nil,
 search backward, otherwise forward."
    (let ((string (car-safe regexp-search-ring))
	  (move (if forward 'forward-char 'backward-char))
	  (end (if forward 'eobp 'bobp)))
      (setq isearch-forward forward)
      (cond
       ((and (memq last-command
		   '(evil-search-symbol-forward
		     evil-search-symbol-backward))
	     (stringp string)
	     (not (string= string "")))
	(evil-search string forward t))
       (t
	(setq string (evil-find-symbol forward))
	(if (null string)
	    (error "No symbol under point")
	  (setq string (format "\\_<%s\\_>" (regexp-quote string))))
	(evil-search string forward t)))))
  :config
  (evil-mode 1)
  (evil-define-motion evil-search-symbol-backward (count)
    "Search backward for symbol under point."
    :jump t
    :type exclusive
    (dotimes (var (or count 1))
      (evil-search-symbol nil)))
  (evil-define-motion evil-search-symbol-forward (count)
    "Search backward for symbol under point."
    :jump t
    :type exclusive
    (dotimes (var (or count 1))
      (evil-search-symbol t)))
  :bind
  (:map evil-motion-state-map
	("#" . evil-search-symbol-backward)
	("*" . evil-search-symbol-forward)
	("C-]" . helm-etags-select)))

;;; ** evil-easymotion
(use-package evil-easymotion
  :ensure t
  :config
  (define-key evil-motion-state-map (kbd ",") nil)
  (evilem-define (kbd ", j") #'next-line)
  (evilem-define (kbd ", k") #'previous-line)
  (evilem-define (kbd ", , w") #'evil-forward-word-begin)
  (evilem-define (kbd ", , W") #'evil-forward-WORD-begin)
  (evilem-define (kbd ", , e") #'evil-forward-word-end)
  (evilem-define (kbd ", , E") #'evil-forward-WORD-end)
  (evilem-define (kbd ", , b") #'evil-backward-word-begin)
  (evilem-define (kbd ", , B") #'evil-backward-WORD-begin)
  (evilem-define (kbd ", , ge") #'evil-backward-word-end)
  (evilem-define (kbd ", , gE") #'evil-backward-WORD-end)
  (evilem-define (kbd ", , n") #'evil-search-next
		 :bind (((symbol-function #'isearch-lazy-highlight-update)
			 #'ignore)
			(search-highlight nil))))

;;; ** evil-nerd-commenter
(use-package evil-nerd-commenter
  :ensure t
  :config
  (global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
  (global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
  (global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
  (global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs))

;;; ** key-chord
;; for mapping escape key in evil-mode
(use-package key-chord
  :ensure t
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))
