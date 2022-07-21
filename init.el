
(setq inhibit-startup-message t)     ;; disable startup message

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(scroll-bar-mode -1)                 ;; disable visual scrollbar
(tool-bar-mode -1)                   ;; disable the toolbar
(tooltip-mode -1)                    ;; disable tooltips
(set-fringe-mode 10)                 ;; give some breathing room

(menu-bar-mode -1)                   ;; disable menu bar
;; Set font face 
(set-face-attribute 'default nil :font "Droid Sans Mono for Powerline" :height 200)

;; Doesn't blind us ;)
;; Also changed by doom-themes
(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; Initialize package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)
;; disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(web-mode org-bullets magit counsel-projectile projectile all-the-icons doom-themes helpful which-key counsel ivy-rich rainbow-delimiters doom-modeline ivy command-log-mode use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package all-the-icons)

;;(use-package doom-modeline
;;  :ensure t
;;  :init (doom-modeline-mode 1)
;;  :custom ((doom-modeline-height 4)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-h f" . counsel.describe-function)
	 ("C-h v" . counsel.describe-variable)
	 ("C-c k" . counsel.ag)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe.variable)
  ([remap describe-key] . helpful-key))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-tomorrow-night t))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Desktop/Code")
    (setq projectile-project-search-path `("~/Desktop/Code")))
  (setq projectile-switch-project-aciton #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(defun sea/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . sea/org-mode-setup)
  :config
  (setq org-ellipsis " |"))

(use-package org-bullets
  :after org
  :hook (org-mode .org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("-" "." "*" "+" "=" "o")))

;; Web Dev Setup
(setq web-mode-enable-auto-closing t)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; Auto close things
(electric-pair-mode 1)
