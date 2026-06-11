# Neovim config

AIペアプログラミングに最適化したスリム構成(~25プラグイン)。
LazyVim のプラグイン選定・設定を参考に、folke 系プラグイン中心で構成。

## 構成

chezmoi ソース(`exact_` プレフィックスは配備時に剥がれ、ディレクトリ内容が完全同期される):

```
dot_config/nvim/
├── init.lua                  # leader設定 → options → lazy.nvim → keymaps/autocmds
└── exact_lua/                # → ~/.config/nvim/lua/
    ├── options.lua           # vim options
    ├── keymaps.lua           # プラグイン非依存キーマップ + smart_close/閉じバッファ復元
    ├── autocmds.lua          # IME自動オフ, active窓のみcursorline, yank highlight等
    └── exact_plugins/        # → lua/plugins/ (lazy.nvim が import)
        ├── colorscheme.lua   # tokyonight (moon)
        ├── snacks.lua        # picker / explorer / lazygit / notifier / words / indent...
        ├── editor.lua        # flash / which-key / gitsigns / trouble / todo-comments / grug-far / yazi / suda
        ├── coding.lua        # blink.cmp / mini.pairs / mini.ai / ts-comments / lazydev
        ├── treesitter.lua    # nvim-treesitter (main branch) + textobjects
        ├── lsp.lua           # nvim-lspconfig + mason v2 (vim.lsp.config/enable)
        ├── format.lua        # conform.nvim (format on save)
        ├── lang.lua          # vtsls / pyright / ruff / dartls
        ├── ui.lua            # bufferline / lualine / mini.icons
        └── ai.lua            # sidekick.nvim (Claude Code, tmuxバックエンド)
```

## キーマップ(3-leader構造)

- `<space>` **main leader** — 1文字で頻出アクション
  - `<space><space>` ファイル検索 / `<space>e` サイドバーツリー / `<space>f` yazi /
    `<space>g` lazygit / `<space>s` grep / `<space>r` 置換(grug-far) /
    `<space>a` Claude起動(n)・選択送信(x) / `<space>y` 相対パスyank / `<space>.` code action
- `,` **sub leader** — 2文字でカテゴリ別
  - `,a*` AI(sidekick) / `,l*` LSP / `,g*` git / `,b*` buffer / `,u*` トグル
- `<tab>` **picker leader** — Snacks.picker 系
  - `<tab>f` files / `<tab>s` grep / `<tab>b` buffers / `<tab>r` recent / `<tab>d` diagnostics 等

直接キー: `K`/`J` バッファ次/前 / `gh` hover / `H`/`L` ジャンプ履歴 /
`C` smart close / `X` 閉じたバッファ復元 / `<c-s>` 保存 / `s` flash jump /
`<c-space>` treesitter選択拡張 / `<c-.>` AI CLIフォーカス

## 必要な外部ツール

- Neovim >= 0.11.2
- `tree-sitter` CLI (>= 0.25, treesitter main branch のパーサビルドに必要)
- `rg`, `fd`, `lazygit`, `yazi`, `tmux` (>= 3.2), `claude` (Claude Code)
- 言語: `node` (vtsls/prettierd), `dart` (dartls は SDK 同梱、mason外)
- IME: `im-select` (macOS) / `fcitx5-remote` (Linux)
