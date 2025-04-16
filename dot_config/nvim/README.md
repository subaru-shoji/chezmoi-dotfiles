ディレクトリの目安（これから目指す）

```
~/.config/nvim/
├── init.lua
└── lua
    ├── core
    │   ├── options.lua          # 基本設定 (行番号, 折り返し, clipboard等)
    │   ├── keymaps.lua          # キーバインド (汎用)
    │   ├── autocmds.lua         # Autocmd (イベント)
    │   ├── registers.lua        # レジスタ操作, ヤンクハイライト, システムクリップボード
    │   ├── macros.lua           # Vimマクロの管理/ヘルパー
    │   ├── jump.lua             # 行ジャンプ, 単語ジャンプ, tagジャンプ, Helix風マルチカーソル移動
    │   ├── selection.lua        # 選択/ビジュアルモード, マルチカーソル, Kakoune/Helix風操作
    │   ├── search_replace.lua   # 検索・置換 (incsearch, hlsearch, clever-f, spectre等)
    │   ├── quickfix.lua         # Quickfix/Location list, bqfなど
    │   └── ...
    ├── plugins
    │   ├── init.lua             # プラグインマネージャ (lazy.nvim/packer.nvim) の本体設定
    │   ├── base
    │   │   ├── lsp.lua          # nvim-lspconfig, mason, null-ls 等の全体設定
    │   │   ├── cmp.lua          # コード補完 (nvim-cmp, luasnip)
    │   │   ├── dap.lua          # デバッガ (nvim-dap, dap-ui)
    │   │   ├── treesitter.lua   # Treesitterの設定
    │   │   ├── telescope.lua    # Telescope (ファジーファインダ)
    │   │   ├── git.lua          # Git (fugitive, gitsigns, lazygit)
    │   │   ├── statusline.lua   # ステータスライン (lualine, galaxyline等)
    │   │   ├── bufferline.lua   # バッファライン (barbar, bufferline.nvim)
    │   │   ├── filetree.lua     # ファイルツリー (nvim-tree, neotree)
    │   │   ├── terminal.lua     # ターミナル統合 (toggleterm等)
    │   │   └── ...
    │   ├── motions
    │   │   ├── hop.lua          # Hop/Lightspeed/Leapなどの移動系
    │   │   ├── easymotion.lua   # EasyMotion (もし別途使う場合)
    │   │   ├── textobjects.lua  # テキストオブジェクト系プラグイン (vim-textobj-*, treesitter-textobjects)
    │   │   └── ...
    │   ├── editing
    │   │   ├── surround.lua     # Surround操作 (vim-surround, nvim-surround)
    │   │   ├── comment.lua      # コメントアウト関連 (Comment.nvim, vim-commentary)
    │   │   ├── autopairs.lua    # 自動括弧挿入 (nvim-autopairs等)
    │   │   └── ...
    │   ├── project
    │   │   ├── project_nvim.lua # project.nvim (自動ルート検出)
    │   │   └── ...
    │   ├── git
    │   │   └── github.lua       # GitHub連携 (cliやocto.nvim)
    │   ├── ai
    │   │   ├── chatgpt.lua      # ChatGPT API/プラグイン設定
    │   │   ├── openai.lua       # OpenAI連携 (コード補完や対話UI)
    │   │   ├── codegpt.lua      # ほかのAI補完 (CodeGPT)
    │   │   └── tabnine.lua      # Tabnine設定
    │   └── ...
    ├── lsp
    │   ├── init.lua             # LSP全体の共通設定 (on_attach, capabilities)
    │   ├── servers.lua          # 各言語サーバの登録 (pyright, tsserver, rust_analyzer等)
    │   ├── format.lua           # フォーマット設定 (null-lsやformatter.nvim)
    │   ├── code_actions.lua     # コードアクション関連拡張
    │   ├── rename.lua           # リネーム機能 (LSP内蔵やinc-rename等)
    │   ├── diagnostics.lua      # 診断表示(virtual text, signs, float windowの設定)
    │   ├── hover.lua            # ホバー表示のカスタム, peek definition等
    │   └── ...
    ├── ui
    │   ├── colorscheme.lua      # カラースキーム(グローバル設定)
    │   ├── highlights.lua       # シンタックス/ハイライト上書き
    │   ├── indentline.lua       # インデント可視化 (indent-blankline等)
    │   ├── cursorline.lua       # カーソルライン設定
    │   ├── icons.lua            # DeviconsやUnicodeアイコン
    │   ├── alpha.lua            # 起動画面 (alpha-nvim) 等
    │   └── ...
    ├── windows
    │   ├── splits.lua           # ウィンドウ分割のデフォルト挙動 (splitbelow, splitright等)
    │   ├── navigation.lua       # ウィンドウ/バッファ/タブ移動のキーマップ
    │   ├── tabs.lua             # タブページ管理 (tabline等)
    │   └── layout.lua           # レイアウト固定や自動リサイズプラグイン (focus.nvim等)
    ├── features
    │   ├── fuzzy_search.lua     # fzf, telescope拡張, denite等の高度検索
    │   ├── advanced_rename.lua  # Grep+置換+リネームを組み合わせた独自機能
    │   ├── build_runner.lua     # ビルド/タスク実行系 (Neomake, TaskRunner等)
    │   └── ...
    ├── commands
    │   ├── custom_commands.lua  # コマンド定義 (command! MyXxx ...)
    │   └── ...
    └── utils
        ├── functions.lua        # 汎用Lua関数
        ├── keymap_utils.lua     # キーマップ関連ヘルパー
        ├── path_utils.lua       # パス操作関連
        ├── string_utils.lua     # 文字列操作
        ├── table_utils.lua      # テーブル操作
        └── ...
```
