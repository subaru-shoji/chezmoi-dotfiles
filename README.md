# chezmoi-dotfiles ドキュメント

## 概要

このリポジトリは [chezmoi](https://www.chezmoi.io/) を使用して管理されている dotfiles（設定ファイル）のコレクションです。様々な開発ツールやアプリケーションの設定が含まれており、複数のマシン間で一貫した開発環境を維持するのに役立ちます。

## chezmoi とは

chezmoi は、複数のマシン間で dotfiles を管理するためのツールです。以下の特徴があります：

- 設定ファイルの変更を追跡し、Git などのバージョン管理システムと統合
- 機密情報（パスワードなど）を安全に管理
- 異なるマシン間で設定を同期
- テンプレートを使用して、マシンごとに設定をカスタマイズ

## インストール方法

### 1. chezmoi のインストール

```bash
# macOS
brew install chezmoi

# Linux
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

# Windows (PowerShell)
(irm -useb get.chezmoi.io/ps1) | powershell -c -
```

### 2. このリポジトリの dotfiles を適用する

```bash
# リポジトリをクローンして初期化
chezmoi init git@github.com:subaru-shoji/chezmoi-dotfiles.git

# 変更を確認（実際に適用する前に）
chezmoi diff

# 設定を適用
chezmoi apply
```

## リポジトリの構造

このリポジトリは以下のような構造になっています：

- `bin/`: 実行可能なスクリプトファイル
- `dot_config/`: 各種アプリケーションの設定ファイル（`~/.config/` にマッピング）
- `dot_Xmodmap`: X Window System のキーマッピング設定（`~/.Xmodmap` にマッピング）
- `dot_pam_environment`: PAM 環境変数の設定（`~/.pam_environment` にマッピング）
- `private_dot_emacs.d/`: Emacs の設定ディレクトリ（`~/.emacs.d/` にマッピング）
- `private_dot_local/`: ローカルユーザー設定（`~/.local/` にマッピング）
- `.chezmoiexternal.toml`: 外部リポジトリからの依存関係を定義

### ファイル名の規則

chezmoi では、ファイル名の接頭辞によって特別な処理が行われます：

- `dot_`: ドット（`.`）で始まるファイルに変換されます（例：`dot_config` → `.config`）
- `executable_`: 実行可能なファイルとして設定されます
- `private_`: 権限が 600（所有者のみ読み書き可能）に設定されます
- `symlink_`: シンボリックリンクとして作成されます

## 主な設定ファイル

このリポジトリには以下のツールやアプリケーションの設定が含まれています：

### シェルと端末

- **Fish Shell**: `dot_config/private_fish/`
- **Alacritty**: `dot_config/alacritty/`
- **Wezterm**: `dot_config/wezterm/`
- **Tmux**: `dot_config/tmux/`
- **Zellij**: `dot_config/zellij/`
- **Starship**: `dot_config/starship.toml`

### エディタとIDE

- **Neovim**: `dot_config/nvim/`
- **Helix**: `dot_config/helix/`
- **Emacs**: `private_dot_emacs.d/`

### ウィンドウマネージャとデスクトップ環境

- **i3**: `dot_config/i3/`
- **i3blocks**: `dot_config/i3blocks/`
- **Picom**: `dot_config/picom/`
- **Yabai**: `dot_config/yabai/`
- **Sketchybar**: `dot_config/sketchybar/`

### 入力メソッドと入力設定

- **Fcitx5**: `dot_config/private_fcitx5/`
- **Karabiner**: `dot_config/private_karabiner/`
- **Xmodmap**: `dot_Xmodmap`

### ファイルマネージャとユーティリティ

- **Ranger**: `dot_config/ranger/`
- **Broot**: `dot_config/broot/`
- **Lazygit**: `dot_config/lazygit/`
- **Tig**: `dot_config/tig/`

## 便利なスクリプト

`bin/` ディレクトリには以下のような便利なスクリプトが含まれています：

- `ide`: 開発環境を素早く起動するためのスクリプト
- `fcitx-en-layout.fish` / `fcitx-jp-layout.fish`: 入力メソッドを切り替えるスクリプト
- `screenshot-window.fish`: ウィンドウのスクリーンショットを撮るスクリプト
- `suspend.fish`: システムをサスペンド状態にするスクリプト
- `switch-to-greeter.fish`: ログイン画面に切り替えるスクリプト

## 外部依存関係

`.chezmoiexternal.toml` ファイルには、以下の外部リポジトリが定義されています：

- **tig-theme-molokai-like**: Tig 用のテーマ
- **asdfzf**: asdf バージョンマネージャ用のfuzzyファインダー
- **ranger_devicons**: Ranger ファイルマネージャ用のアイコン
- **i3blocks-contrib**: i3blocks 用のコントリビューションスクリプト

## カスタマイズ方法

### 1. 既存の設定を変更する

```bash
# 設定ファイルを編集
chezmoi edit ~/.config/fish/config.fish

# 変更を適用
chezmoi apply
```

### 2. 新しい設定ファイルを追加する

```bash
# ファイルを追加
chezmoi add ~/.config/新しいアプリ/config

# 変更をコミット
cd $(chezmoi source-path)
git add .
git commit -m "新しい設定ファイルを追加"
git push
```

### 3. 設定を更新する

```bash
# リポジトリから最新の変更を取得
chezmoi update

# または、変更を確認してから適用
chezmoi update --dry-run
chezmoi update
```

## トラブルシューティング

### 設定が正しく適用されない場合

```bash
# 差分を確認
chezmoi diff

# 強制的に再適用
chezmoi apply --force
```

### 変更を元に戻す場合

```bash
# 特定のファイルを元に戻す
chezmoi forget ~/.config/問題のあるファイル

# 再度リポジトリから取得
chezmoi init --force
```

## 参考リンク

- [chezmoi 公式ドキュメント](https://www.chezmoi.io/docs/quick-start/)
- [chezmoi GitHub リポジトリ](https://github.com/twpayne/chezmoi)