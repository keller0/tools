;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(add-to-list 'load-path "~/elisp")
;;(require 'php-mode)
(require 'ido)
(ido-mode t)
(setq-default tab-width 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(blink-cursor-mode t)
 '(blink-matching-delay 3)
 '(custom-enabled-themes (quote (misterioso)))
 '(ido-enable-flex-matching nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
	(("gnu" . "http://elpa.emacs-china.org/gnu/")
	 ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
 '(package-selected-packages
   (quote
	(protobuf-mode go-guru auto-complete yaml-mode dockerfile-mode go-playground smart-tab go-imports smart-tabs-mode go-mode ac-php-core egg web-mode erlang w3)))
 '(server-mode t)
 '(tool-bar-mode nil))

;;
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))
(global-set-key (kbd "C-x |") 'toggle-window-split)


(smart-tabs-insinuate 'c)
(setq cua-auto-tabify-rectangles nil)
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(global-set-key (kbd "C-x L") `linum-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(eval-after-load "org"
  '(require 'ox-md nil t))
(put 'upcase-region 'disabled nil)
