; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

(add-to-list 'load-path "~/.emacs.d/elisp/")

;; ------------------------------------------------------------------------
;; @ server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; ------------------------------------------------------------------------
;; @ general

;; 縦に分割
(global-set-key [(super d)] "\C-x3")
(global-set-key [(super t)] "\C-x0")

;; スクロール速度を遅く
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)

;; カーソル位置から行頭まで削除する
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0))
;; C-S-kに設定
(global-set-key (kbd "C-S-k") 'backward-kill-line)

;; C-k の拡張．行頭にいる場合は，改行も削除
(setq kill-whole-line t)

;; find file のデフォルトパスを設定
 (setq default-directory "~/")

;; エラー音を消す
(setq ring-bell-function 'ignore)

;; common lisp
(require 'cl)

;; c-hにbackspaceを割り当て
(keyboard-translate ?\C-h ?\C-?)

;; 文字コード
(set-language-environment "Japanese")
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (prefer-coding-system 'utf-8-unix)
         (set-default-coding-systems 'utf-8-unix)
         (setq file-name-coding-system 'sjis)
         (setq locale-coding-system 'utf-8))
        ((eq ws 'ns)
         (require 'ucs-normalize)
         (prefer-coding-system 'utf-8-hfs)
         (setq file-name-coding-system 'utf-8-hfs)
         (setq locale-coding-system 'utf-8-hfs))))

;; Windowsで英数と日本語にMeiryoを指定
;; Macで英数と日本語にRictyを指定
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (set-face-attribute 'default nil
                             :family "Meiryo"  ;; 英数
                             :height 100)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))  ;; 日本語
        ((eq ws 'ns)
         (set-face-attribute 'default nil
                             :family "Ricty"  ;; 英数
                             :height 140)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Hiragino Kaku Gothic ProN")))))  ;; 日本語

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; ツールバー非表示
(tool-bar-mode -1)

;; メニューバーを非表示
(menu-bar-mode -1)

;; スクロールバー非表示
;;(set-scroll-bar-mode nil)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#ffffff"
                    :height 0.9)

;; 行番号フォーマット
(setq linum-format "%4d")

;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; 括弧の範囲色
(set-face-background 'show-paren-match-face "#3f4852")


;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; 選択領域の色
;;(set-face-background 'region "#555")

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#cd4c51")

;; ファイル保存時に行末の空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; タブ幅
(custom-set-variables '(tab-width 2))

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; バックアップを残さない
(setq make-backup-files nil)

;; 行間
(setq-default line-spacing 0.2)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(1.0))

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; 画面移動
(global-set-key (kbd "S-<left>")  'windmove-left)
(global-set-key (kbd "S-<down>")  'windmove-down)
(global-set-key (kbd "S-<up>")    'windmove-up)
(global-set-key (kbd "S-<right>") 'windmove-right)

(global-set-key (kbd "C-S-b")  'windmove-left)
(global-set-key (kbd "C-S-n")  'windmove-down)
(global-set-key (kbd "C-S-p")    'windmove-up)
;;(global-set-key (kbd "H-S-f") 'windmove-right)
(global-set-key (kbd "C-S-f") "\C-xo")

;; ------------------------------------------------------------------------
;; @ modeline

;; モードラインの割合表示を総行数表示
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
        ((eq column-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))

;; モードラインに行番号表示
(line-number-mode t)

;; モードラインに列番号表示
(column-number-mode t)

;; ------------------------------------------------------------------------
;; @ Window Setting

;; 起動時にウィンドウ最大化
;; http://www.emacswiki.org/emacs/FullScreen#toc12
(defun jbr-init ()
  "Called from term-setup-hook after the default
   terminal setup is
   done or directly from startup if term-setup-hook not
   used.  The value
   0xF030 is the command for maximizing a window."
  (interactive)
  (w32-send-sys-command #xf030)
  (ecb-redraw-layout)
  (calendar))

(let ((ws window-system))
  (cond ((eq ws 'w32)
         (set-frame-position (selected-frame) 0 0)
         (setq term-setup-hook 'jbr-init)
         (setq window-setup-hook 'jbr-init))
        ((eq ws 'ns)
         ;; for MacBook Air(Late2010) 11inch display
         (set-frame-position (selected-frame) 0 0)
         (set-frame-size (selected-frame) 202 53))))


;; ------------------------------------------------------------------------
;; @ key bind


(define-key global-map (kbd "M-|") "\\")
(global-set-key (kbd "C-r")     'replace-string)

;; ------------------------------------------------------------------------
;; @ auto-install.el

;; パッケージのインストールを自動化
;; http://www.emacswiki.org/emacs/auto-install.el
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;; ------------------------------------------------------------------------
;; @ tabbar.el

;; タブ化
;; http://www.emacswiki.org/emacs/tabbar.el

(require 'tabbar)
(tabbar-mode 1)
;;
;; ref: http://d.hatena.ne.jp/plasticster/20110825/1314271209
;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; タブに表示させるバッファの設定
(defvar my-tabbar-displayed-buffers
  '("*Backtrace*" "*Colors*" "*Faces*" "*vc-" "*shell*")
  "*Regexps matches buffer names always included tabs.")

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; appearances
(setq tabbar-separator '(1.0)) ;; タブセパレータの長さ
(set-face-attribute 'tabbar-default nil
                    :family "Ricty"
                    :foreground "#ecf4fa"
                    :background "#2f2f2f"
                    :height 1.0)
(set-face-attribute 'tabbar-unselected nil
                    :foreground "#374043"
                    :background "#b2d9f7"
                    :box nil)
(set-face-attribute 'tabbar-selected nil
                    :foreground "#374043"
                    :background "#55acee"
                    :box nil)
(set-face-attribute 'tabbar-button nil
                    :box nil)
(set-face-attribute 'tabbar-separator nil
                    :foreground "#161616"
                    :background "#2f2f2f"
                    :height 1.1)

;; key bindings
(global-set-key [(C-<left>)]   'tabbar-forward-tab)
(global-set-key [(C-<right>)] 'tabbar-backward-tab)
(global-set-key [(super f)]      'tabbar-forward-tab)
(global-set-key [(super b)]      'tabbar-backward-tab)


;; ------------------------------------------------------------------------
;; @ multi-term.el

;; 端末エミュレータ
;; http://www.emacswiki.org/emacs/multi-term.el
(require 'multi-term)
(when (require 'multi-term nil t)
  (setq multi-term-program "/bin/zsh"))

(add-hook 'term-mode-hook
          '(lambda ()
             (yas-minor-mode -1)
             ))

;; ------------------------------------------------------------------------
;; @ auto-async-byte-compile.el

;; 自動コンパイル
;; http://www.emacswiki.org/emacs/auto-async-byte-compile.el
(when (require 'auto-async-byte-compile nil t)
  ;; 自動コンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "init.el")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))



;; ------------------------------------------------------------------------
;; @ anything.el

;; 総合インタフェース
;; http://d.hatena.ne.jp/rubikitch/20100718/anything
(require 'anything-startup nil t)
(define-key global-map (kbd "C-l") 'anything)
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(setq kill-ring-max 100)
(define-key global-map [(control w)] 'anything-M-x)


;; ------------------------------------------------------------------------
;; @ recentf and recentf-ext.el の設定
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 100)      ;; recentf に保存するファイルの数
(require 'recentf-ext)

;; ------------------------------------------------------------------------
;; @ yasnippet

;; スニペット

;; yasnippetを置いているフォルダにパスを通す
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/elisp/yasnippet"))
;; (require 'yasnippet)
;; ;; ~/.emacs.d/にsnippetsというフォルダを作っておきましょう
;; (setq yas-snippet-dirs
;;       '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
;;         "~/.emacs.d/elisp/yasnippet/snippets" ;; 最初から入っていたスニペット(省略可能)
;;         ))
;; (yas-global-mode 1)

;; ;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; ;; (setqだとtermなどで干渉問題ありでした)
;; ;; もちろんTAB以外でもOK 例えば "C-;"とか
;; (custom-set-variables '(yas-trigger-key "TAB"))

;; ;; 既存スニペットを挿入する
;; (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; ;; 新規スニペットを作成するバッファを用意する
;; (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; ;; 既存スニペットを閲覧・編集する
;; (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)


(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")
(when (require 'yasnippet nil t)
  (yas--initialize)
  (yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets")
  (yas/global-mode 1)
)


;; ------------------------------------------------------------------------
;; @ auto-complete.el

;; 自動補完機能
;; https://github.com/m2ym/auto-complete

(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(when (require 'auto-complete-config nil t)
  (ac-config-default)
  (setq ac-auto-start 1)
  (setq ac-dwim t)
  (setq ac-delay 0.02)
  (setq ac-use-fuzzy t)
  (setq ac-use-comphist t)
  (setq ac-auto-show-menu 0.02)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  (setq ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/ac-dict")
  (setq ac-comphist-file "~/.emacs.d/elisp/auto-complete/ac-comphist.dat")
)

;; ------------------------------------------------------------------------
;; @ flycheck

(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
(setq flycheck-display-errors-delay 0.3)
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-n" 'flymake-goto-next-error)
;; ------------------------------------------------------------------------
;; @ MELPA

;; パッケージ
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ------------------------------------------------------------------------
;; @ auto insert

(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/template/")
(define-auto-insert "\\.rb$" "ruby-template.rb")
(define-auto-insert "\\.cpp$" "c++-template.cpp")
(define-auto-insert "\\.py$" "python-template.py")
(define-auto-insert "\\.java$" "java-template.java")

;; ------------------------------------------------------------------------
;; @ Color

;; カラーテーマの読み込み
(setq custom-theme-directory "~/.emacs.d/themes/")
(load-theme 'original t)

;; ------------------------------------------------------------------------
;; @ undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "C-x C-u") 'undo-tree-redo)

;; ------------------------------------------------------------------------
;; @ popwin
(require 'popwin)

;; ------------------------------------------------------------------------
;; @ quickrun
(require 'quickrun)
(push '("*quickrun*") popwin:special-display-config)
(global-set-key (kbd "C-q") 'quickrun)

;; ------------------------------------------------------------------------
;; For folding
;;

;; C coding style
(add-hook 'c-mode-hook
          '(lambda ()
    (hs-minor-mode 1)))
;; Scheme coding style
(add-hook 'scheme-mode-hook
          '(lambda ()
    (hs-minor-mode 1)))
;; Elisp coding style
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
    (hs-minor-mode 1)))
;; Lisp coding style
(add-hook 'lisp-mode-hook
          '(lambda ()
    (hs-minor-mode 1)))
;; Python coding style
(add-hook 'python-mode-hook
          '(lambda ()
    (hs-minor-mode 1)))

(define-key global-map (kbd "C-.") 'hs-toggle-hiding)


;; ------------------------------------------------------------------------
;; Emmet
;;
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; CSSにも使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開



;; ------------------------------------------------------------------------
;; YaTeX
;;

(add-to-list 'load-path "~/.emacs.d/lisp/yatex")
;; YaTeX mode
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
;;(setq tex-command "/Applications/UpTex.app/teTeX/bin/platex")
(setq tex-command "~/bin/platex2pdf.sh")
(setq dvi2-command "open -a Preview")
(setq bibtex-command "/Applications/UpTex.app/teTeX/bin/bibtex")
(setq YaTeX-dvipdf-command "/Applications/UpTex.app/teTeX/bin/dvipdfmx")

;; ------------------------------------------------------------------------
;; Markdown
;;

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))


;; ------------------------------------------------------------------------
;; カラーコードに色付け
;;

(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'php-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)

;; ------------------------------------------------------------------------
;; Powerline
;;

(require 'powerline)

(set-face-attribute 'mode-line nil
:foreground "#374043"
:background "#55acee"
:box nil)

(set-face-attribute 'powerline-active1 nil
:foreground "#374043"
:background "#ecf4fa"
:inherit 'mode-line)

(set-face-attribute 'powerline-active2 nil
:foreground "#374043"
:background "#9bd351"
:inherit 'mode-line)

(powerline-default-theme)

;; ------------------------------------------------------------------------
;; modeの名前を自分で再定義
;;

(defvar mode-line-cleaner-alist
'( ;; For minor-mode, first char is 'space'
(flymake-mode . " Fm")
(flycheck-mode . " Fc")
(paredit-mode . "")
(eldoc-mode . "")
(abbrev-mode . "")
(undo-tree-mode . "")
(git-gutter-mode . "")
(anzu-mode . "")
(yas-minor-mode . "")
(guide-key-mode . "")
;; Major modes

(fundamental-mode . "Fund")
(dired-mode . "Dir")
(lisp-interaction-mode . "Li")
(cperl-mode . "Pl")
(python-mode . "Py")
(ruby-mode . "Rb")
(emacs-lisp-mode . "El")
(markdown-mode . "Md")))

(defun clean-mode-line ()
(interactive)
(loop for (mode . mode-str) in mode-line-cleaner-alist
do
(let ((old-mode-str (cdr (assq mode minor-mode-alist))))
(when old-mode-str
(setcar old-mode-str mode-str))
;; major mode
(when (eq mode major-mode)
(setq mode-name mode-str)))))
(add-hook 'after-change-major-mode-hook 'clean-mode-line)
