function v --wraps=nvim --description 'open in nvim; reuse nvim in current tmux window'
    # tmux外、またはオプション引数付きなら普通に起動
    if not set -q TMUX; or string match -q -- '-*' $argv
        nvim $argv
        return
    end

    # 現在のwindowでnvimが動いているpaneを探す（index順なので最初のマッチが最若）
    set -l pane_id ''
    set -l pane_tty ''
    for line in (tmux list-panes -F '#{pane_id} #{pane_tty} #{pane_current_command}')
        set -l f (string split ' ' $line)
        if test "$f[3]" = nvim
            set pane_id $f[1]
            set pane_tty $f[2]
            break
        end
    end

    if test -z "$pane_id"
        nvim $argv
        return
    end

    # 引数なし: フォーカス移動のみ
    if test (count $argv) -eq 0
        tmux select-pane -t $pane_id
        return
    end

    # tty -> TUIプロセス -> embedサーバー(子プロセス) -> ソケット
    set -l tty (string replace /dev/ '' $pane_tty)
    set -l pids (ps -t $tty -o pid=,comm= | awk '$2 == "nvim" {print $1}')
    if test -n "$pids[1]"
        set -a pids (pgrep -P (string join , $pids) -x nvim)
    end

    # mac: $TMPDIR/nvim.$USER/<乱数>/, linux: /tmp や $XDG_RUNTIME_DIR 配下
    # 注意: 未定義変数を含むbrace展開はfishでは全体が空になるため、リストで持つ
    set -l dirs /tmp
    set -q TMPDIR; and set -p dirs $TMPDIR
    set -q XDG_RUNTIME_DIR; and set -a dirs $XDG_RUNTIME_DIR
    set -l socks
    for pid in $pids
        for dir in $dirs
            set -a socks $dir/nvim.$USER/*/nvim.$pid.*
        end
    end

    if test -z "$socks[1]"
        nvim $argv
        return
    end

    if nvim --server $socks[1] --remote (path resolve -- $argv)
        tmux select-pane -t $pane_id
    else
        # ソケットが死んでいる等 → フォールバック
        nvim $argv
    end
end
