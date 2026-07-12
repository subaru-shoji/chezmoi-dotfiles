# herdr 用の関数・初期化を集約するファイル。herdr の外では何もしない。
# キーバインド([[keys.command]])から呼ぶ場合は HERDR_ENV を明示的に付与して起動する。
if test -z "$HERDR_ENV"
    return
end

function herdr_smart_split -d "ペイン1個なら左右、2個以上なら上下に分割"
    set -l json (herdr pane list)
    set -l pane_id (echo $json | jq -r '.result.panes[] | select(.focused) | .pane_id')
    test -n "$pane_id"; or return 1
    set -l tab_id (echo $json | jq -r '.result.panes[] | select(.focused) | .tab_id')
    set -l count (echo $json | jq --arg t $tab_id '[.result.panes[] | select(.tab_id == $t)] | length')
    if test $count -le 1
        herdr pane split --pane $pane_id --direction right --focus
    else
        herdr pane split --pane $pane_id --direction down --focus
    end
end
