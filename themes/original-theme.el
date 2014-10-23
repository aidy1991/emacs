;;; original-theme.el ---

(deftheme original
  "Aidy color theme")

(custom-theme-set-faces
 'original
 ;; 背景・文字・カーソル
 '(cursor ((t (:foreground "#949da3"))))
 '(default ((t (:background "#1d1d1d" :foreground "#ecf4fa"))))

 ;; 選択範囲
 '(region ((t (:background "#374043"))))

 ;; モードライン
 '(mode-line ((t (:foreground "#ffffff" :background "#4e4e4e"
                  :box (:line-width 1 :color "#4e4e4e" :style released-button)))))
 '(mode-line-buffer-id ((t (:foreground nil :background nil))))
 '(mode-line-inactive ((t (:foreground "#ccd6dd" :background "#2f2f2f"
                           :box (:line-width 1 :color "#2f2f2f")))))

 ;; ハイライト
 '(highlight ((t (:foreground "#1d1d1d" :background "#9bd351"))))
 '(hl-line ((t (:background "#434343"))))

 ;; 関数名
 '(font-lock-function-name-face ((t (:foreground "#55acee"))))

 ;; 型名
 '(font-lock-type-face ((t (:foreground "#55acee"))))

 ;; 変数名・変数の内容
 '(font-lock-variable-name-face ((t (:foreground "#9bd351"))))
 '(font-lock-string-face ((t (:foreground "#cd4c51"))))

'(font-lock-builtin-face ((t (:foreground "#55acee"))))

 ;; 特定キーワード
 '(font-lock-keyword-face ((t (:foreground "#cd7a51"))))

 ;; Boolean
 '(font-lock-constant-face((t (:foreground "#cd7a51"))))

 ;; 括弧
 '(show-paren-match-face ((t (:foreground "#ecf4fa" :background "#3f4852"))))
 '(paren-face ((t (:foreground "#ecf4fa" :background nil))))

 ;; コメント
 '(font-lock-comment-face ((t (:foreground "#cd4c51"))))

 ;; CSS
 '(css-selector ((t (:foreground "#55acee"))))
 '(css-property ((t (:foreground "#cd7a51"))))

 ;; nXML-mode
 ;; タグ名
 '(nxml-element-local-name ((t (:foreground "#cd7a51"))))
 ;; 属性
 '(nxml-attribute-local-name ((t (:foreground "#55acee"))))
 ;; 括弧
 '(nxml-tag-delimiter ((t (:foreground "#9bd351"))))
 ;; DOCTYPE宣言
 '(nxml-markup-declaration-delimiter ((t (:foreground "#434343"))))

 ;; dired
 '(dired-directory ((t (:foreground "#9bd351"))))
 '(dired-symlink ((t (:foreground "#55acee"))))

 ;; MMM-mode
 '(mmm-default-submode-face ((t (:foreground nil :background "#000000")))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'original)
