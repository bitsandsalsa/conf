;;
;; highlighting
;;
(global-set-key [mouse-3]     'my-highlight-word-at-point)
(global-set-key [s-mouse-3]   'my-unhighlight-last-word)
(defvar my-highlighted-words nil)
(make-variable-buffer-local 'my-highlighted-words)
;; variable chooses whether to use built-in hi-lock, or the highlight.el pkg. 
(defvar my-use-highlight-pkg nil)
(defvar my-highlight-faces '('hi-yellow 'hi-green 'hi-pink 'hi-blue
				  'hi-red-b ' hi-green-b))
(defun my-use-highlight-p ()
  (and my-use-highlight-pkg (fboundp 'hlt-highlight-regexp-region)))

(defun my-highlight-word-at-point (&optional nColor)
  (interactive "P")
  (let ((word (current-word t t))
        (face (nth (mod (if nColor nColor 0) (length my-highlight-faces))
                   my-highlight-faces)))
    ;; Updating to use the highlight.el package
    (if (my-use-highlight-p)
        (hlt-highlight-regexp-region (point-min) (point-max) word face)
      ; else fall back to hi-lock 
      (hi-lock-set-pattern word face))
    
    (push (cons word face) my-highlighted-words)))

(defun my-unhighlight-last-word ()
  (interactive) 
  (let* ((word-face (pop my-highlighted-words))
         (word (car word-face))
         (face (cdr word-face)))
    ;; Updating to use the highlight.el package
    (if (my-use-highlight-p)
        (hlt-unhighlight-regexp-region (point-min) (point-max) word face)
      (unhighlight-regexp word))))


;;
;; Python mode hooks
;;
(defun my-insert-pdb-trace ()
  (interactive)
  (insert "import pdb; pdb.set_trace()"))

(add-hook 'python-mode-hook
	(lambda ()
	  (setq indent-tabs-mode t)
	  (setq python-indent 4)
	  (setq tab-width 4)
	  (local-set-key (kbd "C-c g") 'my-insert-pdb-trace)))
(setq default-tab-width 4)


(global-set-key (kbd "C-x C-b") 'ibuffer)
(ido-mode 1) ; a better way to find files and buffers
(ido-everywhere) ; use it everywhere possible
(winner-mode 1) ; cycle through window arangements with C-c <left>,<right>
(server-start) ; start the emacs server
(semantic-mode 1) ; gather semantic content

;; Move to the window to the left/right/up/down of current window with
;; Shift-<left>, Shift-<up>, etc. NOTE: doesn't work in org-mode, b/c
;; org uses those shortcuts for its own things
(windmove-default-keybindings)

;; Use linum-mode if editing a file buffer
(add-hook 'after-change-major-mode-hook
	  '(lambda ()
	     (if (buffer-file-name) (linum-mode 1) )))

;; Set frame title to full file name or buffer name
(setq frame-title-format
	  (list (format "%s %%S: %%j " (system-name))
			'(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; C mode hooks
(defun my-c-mode-hook ()
  (gtags-mode 1))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)


;;
;; -- Load Packages --
;;
(add-to-list 'load-path "~/.emacs.d/lisp")

;;
;; package
;;
(package-initialize)

;;
;; smex
;;
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;
;; magit
;;
(global-set-key (kbd "<f9>") 'magit-status)

;;
;; undo-tree
;;
(global-undo-tree-mode 1)

;;
;; tabbar
;;
(tabbar-mode 1)

;;
;; gtags
;;
(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)))
(setq gtags-suggested-key-mapping t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(dired-dwim-target t)
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(package-archives (quote (("melpa" . "http://melpa.milkbox.net/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(show-paren-mode t)
 '(show-trailing-whitespace t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )