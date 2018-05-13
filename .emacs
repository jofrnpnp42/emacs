;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; パッケージ管理 M-x package-install を有効にする
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shell-mode で使うレジスタ設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-register ?h '("grep -r -n --include=\"*.h\" -w .")) 
(set-register ?g '("grep -r -n --include=\"*.c\"  --include=\"*.h\" --include=\"*.cpp\" -w .")) 
(set-register ?G '("grep -r -n -w .")) 
(set-register ?f '("find . -type f -name \"*.*\"")) 
(set-register ?c '("~/.config/")) 
(set-register ?e '("~/.emacs")) 
(set-register ?E '("~/.emacs.d")) 
(set-register ?p '("https://docs.python.jp/"))
(set-register ?P '("https://docs.python.org/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 背景色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if window-system (progn
  (set-foreground-color "MediumSpringGreen")
  (set-background-color "DarkSlateGray")
  (set-cursor-color "Green")
  (set-mouse-color "YellowGreen")
  (set-face-background 'mode-line "Salmon")
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フォント色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-font-lock-mode)
(setq font-lock-face-attributes
      '((font-lock-comment-face "LimeGreen")
        (font-lock-string-face "SpringGreen")
        (font-lock-keyword-face "yellow")
        (font-lock-function-name-face "MediumSeaGreen")
        (font-lock-variable-name-face "GreenYellow")
        (font-lock-type-face "Gold")
        (font-lock-reference-face "ForestGreen")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; バックアップファイル設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files nil) ;; バックアップファイル(*.~)を作らない
(setq auto-save-default nil) ;; バックアップファイル(#*)を作らない

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 画面表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq line-number-display-limit-width 10000)            ;; 行番号が L? にならないようにする
;(global-linum-mode 1)                                  ;; 行番号を左側に表示する (C-c C-l で表示・非表示を切り替える)
;(setq linum-format "%d ")
;(global-set-key (kbd "C-c C-l") 'global-linum-mode)    ;; C-c C-l で行数表示On/Off切り替え
(setq inhibit-startup-scree t)                          ;; スタートアップ画面を非表示にする
;(setq initial-scratch-message "")                      ;; Scratch Buffer のメッセージを消す
(setq initial-scratch-message nil)                      ;; Scratch 画面を表示しない
(setq inhibit-startup-message t)                        ;; 起動時の画面分割をしない
(add-hook 'after-init-hook (lambda()
                    (shell) (delete-other-windows) ))   ;; Shellモードで起動時、他のバッファ消した状態にする
(setq frame-title-format (format
                    "%%f - Emacs@%s" (system-name)))    ;; タイトルバーにファイルのフルパスを表示する
(fset 'yes-or-no-p 'y-or-n-p)                           ;; yes, no を y, n で済ませる
(tool-bar-mode  0)                                      ;; ツールバを消す
(menu-bar-mode -1)                                      ;; メニューバを消す
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 1))                     ;; マウスホイールでスクロール
(defun scroll-up-with-lines ()
   "" (interactive) (scroll-up 1))                      ;; マウスホイールでスクロール
(setq line-move-visual nil)                             ;; 物理行での移動。Emacsテクニックバイブル: 5.3

;; 起動時のサイズ,表示位置,フォントを指定
(setq initial-frame-alist
      (append (list '(width . 180) '(height . 55)
           '(top . 0) '(left . 0)) initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt) ;; Shellもーどでのパスワード隠し

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フォント書体とサイズ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-face-attribute 'default nil :height 115)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ヒストリー設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq recentf-max-menu-items 1000)                      ;; 最近使ったファイルの表示数
(setq recentf-max-saved-item 3000)                      ;; 最近開いたファイルの保存数を増やす
(global-set-key (kbd "C-c C-v") 'find-alternate-file )  ;; ファイルのフルパスを取得する
(savehist-mode 1)                                       ;; ミニバッファの履歴を保存する
(setq history-length 3000)                              ;; ミニバッファの履歴の保存数を増やす

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 編集処理
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default tab-width 4 indent-tabs-mode nil)         ;; タブスペースを半角4個分にする
(setq indent-tabs-mode nil)                             ;; タブの使用を禁止する
(setq split-width-threshold nil)                        ;; 縦分割の抑制
(setq split-height-threshold nil)                       ;; 横分割の抑制
(global-set-key (kbd "C-c C-g") 'goto-line)             ;; 指定行への移動
(global-set-key (kbd "M-g") 'grep)                      ;; M-x grep モード
(global-set-key (kbd "C-.") 'dabbrev-expand)            ;; Emacsテクニックバイブル: 6.4 バッファから単語を補完する


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: 4.5 ブックマークを変更したら即保存する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq bookmark-save-flag 1)
;; 超整理法(好みに応じて)
(progn
(setq bookmark-sort-flag nil)
(defun bookmark-arrange-latest-top ()
(let ((latest (bookmark-get-bookmark bookmark)))
(setq bookmark-alist (cons latest (delq latest bookmark-alist))))
(bookmark-save))
(add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: ---COLUMN おすすめ設定 --- より
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-h") 'delete-backward-char)      ;;; C-h を BS にする
(global-hl-line-mode 1)                                 ;;; 現在行に色をつける
(set-face-background 'hl-line "darkolivegreen")         ;;; 色
(savehist-mode 1)                                       ;;; 履歴を次回Emacs起動時にも保存する
(setq-default save-place t)                             ;;; ファイル内のカーソル位置を記憶する
(require 'saveplace)
(show-paren-mode 1)                                     ;;; 対応する括弧を表示させる
(global-set-key (kbd "C-h") 'delete-backward-char)      ;;; シェルに合わせるため、C-hは後退に割り当てる
(display-time)                                          ;;; モードラインに時刻を表示する
(line-number-mode 1)                                    ;;; 行番号・桁番号を表示する
(column-number-mode 1)
(transient-mark-mode 1)                                 ;;; リージョンに色をつける
(setq gc-cons-threshold (* 10 gc-cons-threshold))       ;;; GCを減らして軽くする(デフォルトの10倍)
(setq message-log-max 10000)                            ;;; ログの記録行数を増やす
(setq enable-recursive-minibuffers t)                   ;;; ミニバッファを再帰的に呼び出せるようにする
(setq use-dialog-box nil)                               ;;; ダイアログボックスを使わないようにする
(defalias 'message-box 'message) 
(setq history-length 1000)                              ;;; 履歴をたくさん保存する
(setq echo-keystrokes 0.1)                              ;;; キーストロークをエコーエリアに早く表示する
(setq large-file-warning-threshold (* 25 1024 1024))    ;;; 大きいファイルを開こうとしたときに警告を発生させる(25MB)
(scroll-bar-mode -1)                                    ;;; スクロールバーを消す
(defadvice abort-recursive-edit (before minibuffer-save activate)   ;;; ミニバッファで入力を取り消しても履歴に残す
    (when (eq (selected-window) (active-minibuffer-window))         ;;; 誤って取り消して入力が失われるのを防ぐため
        (add-to-history minibuffer-history-variable (minibuffer-contents))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル 4.2: ファイル名が重複した場合にバッファ名をわかりやすくする
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; *で囲まれたバッファ名は対象外にする
(setq uniquify-ignore-buffers-re "*[^*]+*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル 4.3: iswitchb.el (C-x b -> C-s C-r で選択可能)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(iswitchb-mode 1)
;; バッファ読み取り関数を iswitchb にする
(setq read-buffer-function 'iswitchb-read-buffer)
;; 部分文字列の代わりに正規表現を使う場合は t に設定する
(setq iswitchb-regexp nil)
;; 新しいバッファを作成するときにいちいち聞いてこない
(setq iswitchb-prompt-newbuffer nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル 8.4: w3m.el (Webブラウザとする)
;; # apt-get install w3m
;; # apt-get install cvs
;; % cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/emacs-w3m")
(load "w3m.el")
(setq browse-url-browser-function 'w3m-browse-url) ;; Emacs(14.9)
(setq org-return-follows-link t)                   ;; 行頭RETでリンクを辿る
(global-set-key "\C-xw" 'w3m)                      ;; C-c w で w3m を起動
;(global-set-key "\C-xu" 'browse-url-at-point)      ;; C-c u でカーソル下の語を検索しつつブラウザー起動
(global-set-key [mouse-2] 'browse-url-at-mouse)    ;; 中クリックでブラウザー起動
;(setq browse-url-new-window-flag t)                ;; 新規タブで browse-url する
(setq w3m-use-cookies t)                           ;; Cookie 有効にする

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル 13.4: ediff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; パッケージインストールにより自動入力された記述.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (avy shell-history anything open-junk-file auto-complete redo+ goto-chg point-undo smooth-scroll smooth-scrolling recentf-ext auto-install))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル 4.4: 最近使ったファイルを開く(recent-ext.el)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 500)
;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smooth-scroll: C-v,M-v  C-M-v,C-M-V をスムーズにする
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq smooth-scroll/vscroll-step-size 4) ;; 縦方向のスクロール行数を変更する。
(setq smooth-scroll/hscroll-step-size 4) ;; 横方向のスクロール行数を変更する。
;; smooth-scrolling
(require 'smooth-scrolling)
(smooth-scroll-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: 5.6 point-undo. カーソル位置の復元
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: 5.8 goto-chg. 最後の変更箇所に移動
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: 6.2 redo+ 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'redo+)
(global-set-key (kbd "M-/") 'redo)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
;; 大量のundoに耐えられるようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; Emacsテクニックバイブル: 6.14 auto-complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(require 'auto-complete-config)
(global-auto-complete-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; Emacsテクニックバイブル: 13.1 open-junk-file.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(setq open-junk-file-format "~/junk/%Y-%m-%d-%H%M%S.")
(global-set-key (kbd "M-j") 'open-junk-file )  ;; ファイルのフルパスを取得する

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: 2.2 auto-install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (install-elisp-from-emacswiki "auto-install.el")
(require 'auto-install)
;; auto-installによってインストールされるEmacs Lispをロードパスに加える
;; デフォルトは ∼ /.emacs.d/auto-install/
(add-to-list 'load-path auto-install-directory)
;; 起動時にEmacsWikiのページ名を補完候補に加える
(auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
(auto-install-compatibility-setup)
;; ediff関連のバッファを1つのフレームにまとめる
(setq ediff-window-setup-function 'ediff-setup-windows-plain)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL (gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/gtags")
(require 'gtags)
(require 'anything-gtags)
(add-hook 'c-mode-common-hook 'gtags-mode)
(add-hook 'c++-mode-hook 'gtags-mode)
(add-hook 'java-mode-hook 'gtags-mode)

(setq gtags-path-style 'relative)             ;相対パス表示にする
(global-set-key "\M-t" 'gtags-find-tag)       ;関数の定義場所の検索
(global-set-key "\M-r" 'gtags-find-rtag)      ;関数や使用箇所の検索
(global-set-key "\M-S" 'gtags-find-symbol)    ;変数の使用箇所の検索
(global-set-key "\M-a" 'gtags-pop-stack)      ;タグジャンプした箇所からひとつ戻る
(global-set-key "\M-s" 'gtags-find-with-grep) ;タグファイルを検索する
(setq view-read-only t)  ; 読み込み専用バッファを自動的にview-modeにする
(setq gtags-read-only t) ; 上と合わせることで、タグジャンプ先をview-modeにする。


;; http://d.hatena.ne.jp/kyagi/20080226/1204034637 より、タグファイルの切り替えをする。
;; 個人的な設定として、本家の「F12」キーから「F10」に変更した。
;;; ** gtags-mode
(global-set-key "\M-." 'gtags-find-tag)
(autoload 'gtags-find-tag "gtags" "" t)
(autoload 'gtags-mode "gtags" "" t)
;(add-hook 'gtags-mode-hook 'setnu-mode)

(setq my-gtags-tag-table-alist
	  '(
        ("local-c" . "/home/neko/local/src/c")
        ("local-cpp" . "/home/neko/local/src/cpp")
		))

(defun my-gtags-show-tag-table-alist ()
  (split-window-vertically)
  (other-window 1)
  (switch-to-buffer "*my-gtags-show-tag-table-alist*")
  (let ((n 1) (tag-table) (tag-table-alist))
	(setq tag-table-alist my-gtags-tag-table-alist)
	(while tag-table-alist
	  (setq tag-table (car tag-table-alist))
	  (insert (format "%d %s\n" n (car tag-table)))
	  (setq tag-table-alist (cdr tag-table-alist))
	  (setq n (1+ n)))))

(defun my-gtags-hide-tag-table-alist ()
  (kill-buffer "*my-gtags-show-tag-table-alist*")
  (other-window 1)
  (delete-other-windows))

(defun my-gtags-select-tag-table ()
  (interactive)
  (gtags-mode t)
  (my-gtags-show-tag-table-alist)
  (let ((n 0) (answer) (tag-table) (tag-table-alist))
	(setq tag-table-alist my-gtags-tag-table-alist)
	(setq answer (read-from-minibuffer "which tag table do you want to use?:"))
	(setq answer (string-to-number answer))
	(while (not (= n answer))
	  (setq tag-table (car tag-table-alist))
	  (setq tag-table-alist (cdr tag-table-alist))
	  (setq n (1+ n)))
	(setq-default gtags-rootdir (cdr tag-table)))
  (my-gtags-hide-tag-table-alist)
  (cd gtags-rootdir))

(global-set-key [f10] 'my-gtags-select-tag-table)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacsテクニックバイブル: 9.8 シェルコマンドの実行履歴を保存する (shell-history.el)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'shell-history)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything.el (Emacsテクニックバイブル: 15.x)
;; M-x M-u で anything を起動する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'anything-config)
(require 'anything-startup)
(require 'anything-complete)
(defun my-anything ()
(interactive)
(anything-other-buffer '(anything-c-source-buffers
                         anything-c-source-recentf
                         anything-c-source-complete-shell-history
                         anything-c-source-extended-command-history
                         anything-c-source-minibuffer-history
                        )
"*my anything*"))

;(define-key anything-map (kbd "C-o") 'my-anything)              ;; 独自設定
;(define-key anything-map (kbd "C-o") 'anything-other-buffer)    ;; 別バッファ表示
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
;(define-key anything-map (kbd "C-y") 'anything-show-kill-ring)  ;; kill ring(15.13)
(global-set-key (kbd "C-M-o") 'anything-w3m-bookmarks)          ;; w3m bookmark(15.8)
(global-set-key (kbd "C-M-y") 'anything-show-kill-ring)         ;; kill ring(15.13)
(global-set-key (kbd "M-x M-u") 'anything)
(setq anything-quick-update t)                                  ;; 画面外の情報の更新を遅延させる(15.19)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; update GTAGS (保存するたびに GTAGS を更新する)
;; https://qiita.com/yewton/items/d9e686d2f2a092321e34
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun update-gtags (&optional prefix)
  (interactive "P")
  (let ((rootdir (gtags-get-rootpath))
        (args (if prefix "-v" "-iv")))
    (when rootdir
      (let* ((default-directory rootdir)
             (buffer (get-buffer-create "*update GTAGS*")))
        (save-excursion
          (set-buffer buffer)
          (erase-buffer)
          (let ((result (process-file "gtags" nil buffer nil args)))
            (if (= 0 result)
                (message "GTAGS successfully updated.")
              (message "update GTAGS error with exit status %d" result))))))))
(add-hook 'after-save-hook 'update-gtags)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; avy.el (Vim の easy-motion)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-l") 'avy-goto-char-timer)
;(global-set-key (kbd "M-s") 'avy-goto-line)

