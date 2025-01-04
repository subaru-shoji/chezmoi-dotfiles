;;; package --- Summary
;;; Commentary:
;; Emacsの基本設定に関する情報
;; https://mugijiru.github.io/.emacs.d/basics/?utm_source=pocket_shared
;; https://apribase.net/2024/07/27/modern-emacs-2024/?utm_source=pocket_saves
;; https://a.conao3.com/blog/2024/7c7c265/
;; https://mako-note.com/ja/python-emacs-eglot/

(require 'package) ;; パッケージ管理を有効にする
;;; Code:
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t) ;; MELPAリポジトリを追加

(eval-when-compile
  (setopt use-package-enable-imenu-support t)
  (require 'use-package)) ;; use-packageをコンパイル時に読み込む

;; パフォーマンス向上のための設定
(setq gc-cons-threshold (* 50 1000 1000)) ;; ガベージコレクションの閾値を増やす
(setq file-name-handler-alist nil) ;; 起動時のパフォーマンスを向上

(use-package appearance-config :no-require
  :config
  (use-package all-the-icons
    :ensure t
    :if (display-graphic-p)) ;; GUI環境でのみアイコンを表示
  (use-package doom-themes
    :ensure t
    :config
    ;; グローバル設定 (デフォルト)
    (setq doom-themes-enable-bold t    ; nilの場合、太字が無効
          doom-themes-enable-italic t) ; nilの場合、イタリックが無効
    (load-theme 'doom-one t) ;; doom-oneテーマをロード

    ;; エラー時にモードラインを点滅させる
    (doom-themes-visual-bell-config)
    ;; カスタムneotreeテーマを有効にする (all-the-iconsが必要)
    (doom-themes-neotree-config)
    ;; treemacsユーザー向け設定
    (setopt doom-themes-treemacs-theme "doom-atom") ; より少ないアイコンテーマを使用
    (doom-themes-treemacs-config)
    ;; org-modeのフォント設定を改善
    (doom-themes-org-config))

  (use-package dashboard
    :ensure t
    :config
    (dashboard-setup-startup-hook)) ;; 起動時にダッシュボードを設定

  (use-package moody
    :ensure t
    :config
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode)) ;; モードラインをカスタマイズ

  (use-package dimmer
    :ensure t
    :config
    (dimmer-mode t)) ;; アクティブでないバッファを暗くする
  (use-package nerd-icons
    :ensure t
    ;; :custom
    ;; GUIで使用するNerd Fontを指定
    ;; デフォルトは"Symbols Nerd Font Mono"で推奨される
    ;; 他のNerd Fontも使用可能
    ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
    )


  (use-package aggressive-indent
    :ensure t
    :hook (emacs-lisp-mode . aggressive-indent-mode)) ;; 自動インデントを強化


  (use-package highlight-indent-guides
    :ensure t
    :hook
    (prog-mode . highlight-indent-guides-mode)
    :custom
    (highlight-indent-guides-method 'character)
    (highlight-indent-guides-responsive 'top)
    (highlight-indent-guides-character ?\|)) ;; インデントを強調

  (use-package tree-sitter
    :ensure t
    :config
    (global-tree-sitter-mode)) ;; シンタックスハイライトを強化

  (use-package tree-sitter-langs
    :ensure t)
  (use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
  )

(use-package editor-config :no-require
  :config
  (use-package vundo
    :ensure t) ;; undoツリーを視覚化
  ;; Emacsのpuniパッケージに関する情報
  ;; https://apribase.net/2024/06/17/emacs-puni/
  (use-package puni
    :ensure t
    :config
    (puni-global-mode +1)) ;; puniモードをグローバルに有効化

  (use-package avy
    :ensure t) ;; 高速移動を可能にする

  (use-package multiple-cursors
    :ensure t)

  )

(use-package :project-config :no-require
  :config
  (use-package projectile
    :ensure t
    :config
    (projectile-mode +1)) ;; プロジェクト管理を強化
  )


(use-package window-config :no-require
  :config
  (use-package ace-window
    :ensure t) ;; 窓の切り替えを簡単にする

  )

(use-package git-config :no-require
  :config
  (use-package magit
    :ensure t) ;; Gitインターフェースを提供
  )


(use-package finder-config :no-require
  :config
  ;; verticoを有効化
  (use-package vertico
    :ensure t
    ;; :custom
    ;; (vertico-scroll-margin 0) ;; スクロールマージンを変更
    ;; (vertico-count 20) ;; 候補を多く表示
    ;; (vertico-resize t) ;; Verticoミニバッファのサイズを調整
    ;; (vertico-cycle t) ;; `vertico-next/previous'のサイクリングを有効化
    :init
    (vertico-mode))

  ;; Emacs再起動時に履歴を保持。Verticoは履歴位置でソート。
  (use-package savehist
    :init
    (savehist-mode))

  (use-package hotfuzz
    :ensure t)

  (use-package orderless
    :ensure t
    :custom
    ;; カスタムスタイルディスパッチャを設定 (Consult wiki参照)
    ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
    ;; (orderless-component-separator #'orderless-escapable-split-on-space)
    (completion-styles '(orderless basic hotfuzz))
    (completion-category-defaults nil)
    (completion-category-overrides '((file (styles partial-completion)))))

  (use-package consult
    :ensure t
    :config
  (advice-add 'consult-find :around
            (lambda (orig-fun &rest args)
              (apply orig-fun args :require-match nil)))
             
    ) ;; 検索とナビゲーションを強化

  (use-package consult-dir
    :ensure t
    :after consult) ;; ディレクトリナビゲーションを強化

  (use-package consult-flycheck
    :ensure t
    :after (consult flycheck)) ;; Flycheckのエラーを検索

  (use-package consult-eglot
    :ensure t
    :after (consult eglot)) ;; Eglotのサポートを追加

  (use-package consult-projectile
    :ensure t)

  (use-package marginalia
    :ensure t
    :config
    (marginalia-mode)) ;; 補完候補に追加情報を表示

  (use-package embark
    :ensure t

    ;; :bind
    ;; (("C-." . embark-act)         ;; 快適なバインディングを選択
    ;;  ("C-;" . embark-dwim)        ;; 代替: M-.
    ;;  ("C-h B" . embark-bindings)) ;; `describe-bindings'の代替

    :init

    ;; キーヘルプを補完インターフェースに置き換える
    (setq prefix-help-command #'embark-prefix-help-command)

    ;; Eldocを介してEmbarkターゲットをポイントで表示。複数のプロバイダーからのドキュメントを表示する場合、Eldoc戦略を調整可能。ミニバッファに表示されるメッセージが1行以上になることがあるため、モードラインが上下に動くことに注意。

    ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
    ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

    :config

    ;; Embarkライブ/補完バッファのモードラインを非表示
    (add-to-list 'display-buffer-alist
		 '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                   nil
                   (window-parameters (mode-line-format . none)))))

  ;; Consultユーザーはembark-consultパッケージも必要
  (use-package embark-consult
    :ensure t ; インストールのみ必要、embarkがconsult後にロード
    :after (embark consult)
    :hook
    (embark-collect-mode . consult-preview-at-point-mode))
  
  )


(use-package search-replace-config :no-require
  :config
  (use-package visual-regexp
    :ensure t)
  )

(use-package linter-config :no-require
  :config
  (use-package flycheck
    :ensure t
    :config
    (add-hook 'after-init-hook #'global-flycheck-mode)) ;; コードの静的解析を行う

  )

(use-package tree-config :no-require
  :config
  (use-package treemacs
    :ensure t
    :defer t
    :init
    (with-eval-after-load 'winum
      (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
    (treemacs-project-follow-mode)
    :config
    (progn
      (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
            treemacs-deferred-git-apply-delay        0.5
            treemacs-directory-name-transformer      #'identity
            treemacs-display-in-side-window          t
            treemacs-eldoc-display                   'simple
            treemacs-file-event-delay                2000
            treemacs-file-extension-regex            treemacs-last-period-regex-value
            treemacs-file-follow-delay               0.2
            treemacs-file-name-transformer           #'identity
            treemacs-follow-after-init               t
            treemacs-expand-after-init               t
            treemacs-find-workspace-method           'find-for-file-or-pick-first
            treemacs-git-command-pipe                ""
            treemacs-goto-tag-strategy               'refetch-index
            treemacs-header-scroll-indicators        '(nil . "^^^^^^")
            treemacs-hide-dot-git-directory          t
            treemacs-indentation                     2
            treemacs-indentation-string              " "
            treemacs-is-never-other-window           nil
            treemacs-max-git-entries                 5000
            treemacs-missing-project-action          'ask
            treemacs-move-files-by-mouse-dragging    t
            treemacs-move-forward-on-expand          nil
            treemacs-no-png-images                   nil
            treemacs-no-delete-other-windows         t
            treemacs-project-follow-cleanup          nil
            treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
            treemacs-position                        'left
            treemacs-read-string-input               'from-child-frame
            treemacs-recenter-distance               0.1
            treemacs-recenter-after-file-follow      nil
            treemacs-recenter-after-tag-follow       nil
            treemacs-recenter-after-project-jump     'always
            treemacs-recenter-after-project-expand   'on-distance
            treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
            treemacs-project-follow-into-home        nil
            treemacs-show-cursor                     nil
            treemacs-show-hidden-files               t
            treemacs-silent-filewatch                nil
            treemacs-silent-refresh                  nil
            treemacs-sorting                         'alphabetic-asc
            treemacs-select-when-already-in-treemacs 'move-back
            treemacs-space-between-root-nodes        t
            treemacs-tag-follow-cleanup              t
            treemacs-tag-follow-delay                1.5
            treemacs-text-scale                      nil
            treemacs-user-mode-line-format           nil
            treemacs-user-header-line-format         nil
            treemacs-wide-toggle-width               70
            treemacs-width                           35
            treemacs-width-increment                 1
            treemacs-width-is-initially-locked       t
            treemacs-workspace-switch-cleanup        nil)

      ;; デフォルトのアイコンの幅と高さは22ピクセル。Hi-DPIディスプレイを使用している場合、アイコンサイズを倍にするにはこれをアンコメント。
      ;;(treemacs-resize-icons 44)

      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (treemacs-fringe-indicator-mode 'always)
      (when treemacs-python-executable
	(treemacs-git-commit-diff-mode t))

      (pcase (cons (not (null (executable-find "git")))
                   (not (null treemacs-python-executable)))
	(`(t . t)
	 (treemacs-git-mode 'deferred))
	(`(t . _)
	 (treemacs-git-mode 'simple)))

      (treemacs-hide-gitignored-files-mode nil))
    :bind
    (:map global-map
          ("M-0"       . treemacs-select-window)
          ("C-x t 1"   . treemacs-delete-other-windows)
          ("C-x t t"   . treemacs)
          ("C-x t d"   . treemacs-select-directory)
          ("C-x t B"   . treemacs-bookmark)
          ("C-x t C-t" . treemacs-find-file)
          ("C-x t M-t" . treemacs-find-tag)))

  ;; (use-package treemacs-evil
  ;;   :after (treemacs evil)
  ;;   :ensure t)

  (use-package treemacs-projectile
    :after (treemacs projectile)
    :ensure t) ;; Projectileとの統合を提供

  (use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    :ensure t) ;; Diredでアイコンを表示

  (use-package treemacs-magit
    :after (treemacs magit)
    :ensure t) ;; Magitとの統合を提供

  (use-package treemacs-nerd-icons
    :ensure t
    :config
    (treemacs-load-theme "nerd-icons")) ;; Nerd Iconsテーマをロード

  ;; (use-package treemacs-persp ;;treemacs-perspectiveを使用する場合
  ;;   :after (treemacs persp-mode) ;;またはperspectiveを使用する場合
  ;;   :ensure t
  ;;   :config (treemacs-set-scope-type 'Perspectives))

  ;; (use-package treemacs-tab-bar ;;tab-bar-modeを使用する場合
  ;;   :after (treemacs)
  ;;   :ensure t
  ;;   :config (treemacs-set-scope-type 'Tabs))

  ;; (treemacs-start-on-boot)
  
  )

(use-package format-config :no-require
  :config
  ;; (defun my-indent-whole-buffer ()
  ;;   (interactive)
  ;;   (when (memq major-mode '(emacs-lisp-mode)) ; 対象モードを指定
  ;;     (mark-whole-buffer)
  ;;     (indent-region (region-beginning) (region-end))))

  (add-hook 'before-save-hook 'my-indent-whole-buffer)


  (use-package reformatter
    :ensure t
    :config
    (reformatter-define black
      :program "black"
      :args '("-")
      :lighter " B")
    (add-hook 'python-mode-hook 'black-format-on-save-mode)) ;; Pythonコードを自動フォーマット
  )





(use-package completion-config :no-require
  :config
  (use-package corfu
  :custom ((corfu-auto t)
           (corfu-auto-delay 0)
           (corfu-auto-prefix 1)
           (corfu-cycle t)
           (corfu-on-exact-match nil)
           (tab-always-indent 'complete))
  :bind (nil
         :map corfu-map
         ("TAB" . corfu-insert)
         ("<tab>" . corfu-insert)
         ("RET" . nil)
         ("<return>" . nil))
  :init
  (global-corfu-mode +1))
  )

(use-package lsp-config :no-require
  :config
  (use-package eglot
  :ensure t
  :hook
  (elm-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
  )
)

(use-package elm-config :no-require
  :config
  (use-package elm-mode
    :ensure t
    :hook
    (elm-mode . elm-format-on-save-mode))
  )

(use-package rust-config :no-require
  :config
  (use-package rust-mode
  :ensure t
  :custom
  (rust-format-on-save t))

;; cargoの設定
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))
)

;; meowのキーバインディング設定
;; https://github.com/meow-edit/meow/blob/master/KEYBINDING_QWERTY.org
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (setq meow-use-clipboard t)

  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   '("a" . treemacs)
   ;; SPC j/kはMOTION状態で元のコマンドを実行
   '("j" . "H-j")
   '("k" . "H-k")
   ;; SPC (0-9)は数字引数として使用
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet)
   '("<SPC>" . consult-fd))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '(":" . execute-extended-command)
  ;;  '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("C" . delete-window)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
  ;;  '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)
   '("/" . consult-line)
   '("<tab> b" . consult-buffer-other-window)
   '("<tab> d" . consult-flymake)
   '("<tab> f" . consult-fd)
   '("<tab> g" . consult-ripgrep)
   '("<tab> i" . consult-imenu)
   '("<tab> r" . consult-recent-file)
  '("v c" . puni-mark-list-around-point) ;; コンテンツ
  '("v x" . puni-mark-sexp-around-point) ;; 式
  '("v v" . puni-expand-region)
  '("v l" . meow-line) ;; 行
  '(", a (" . puni-wrap-round)
  '(", a [" . puni-wrap-square)
  '(", a {" . puni-wrap-curly)
  '(", a <" . puni-wrap-angle)
  '(", a d" . puni-splice)
  '(", s l" . puni-slurp-forward)
  '(", b a" . puni-barf-forward)
)
   
  )

(use-package which-key
  :ensure t
  :config
(which-key-mode))

(use-package meow
  :ensure t
  :config
  (meow-global-mode 1)
  (meow-setup)
  ;; :hook
  ;; (messages-buffer-mode . meow-mode)
  )

;; いくつかの便利な設定...
(use-package emacs
  :custom
  ;; 候補が少ない場合、TABでサイクル
  ;; (completion-cycle-threshold 3)

  ;; TABキーでインデント+補完を有効化。
  ;; `completion-at-point'はM-TABにバインドされることが多い。
  (tab-always-indent 'complete)

  ;; Emacs 30以降: Ispell補完関数を無効化。
  ;; 代替として`cape-dict'を試す。
  (text-mode-ispell-word-completion nil)

  ;; 現在のモードに適用されないコマンドをM-xで非表示。CorfuコマンドはM-x経由で使用されないため非表示。この設定はCorfu以外でも有用。
  (read-extended-command-predicate #'command-completion-default-include-p)
  
  ;; use-package emacsに移動する
  (setq use-short-answers t)

  (setq auto-save-default nil) ;; 自動保存を無効化

  (setq make-backup-files nil) ;; バックアップファイルを作成しない
  (setq backup-inhibited nil)
  (setq create-lockfiles nil)


  (setq savehist-file (expand-file-name "~/.local/share/emacs/savehist.el"))
  (savehist-mode 1) ;; 履歴を保存

  (global-auto-revert-mode +1) ;; ファイルが変更された場合、自動で再読み込み
  (tab-bar-mode +1)
  (recentf-mode +1)
  (global-display-line-numbers-mode 1)
  (global-tree-sitter-mode)
  )

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p (expand-file-name custom-file))
  (load-file (expand-file-name custom-file)))

(set-face-attribute 'default nil :font "Hack Nerd Font Mono-12")

(provide 'init)
;;; init.el ends here
