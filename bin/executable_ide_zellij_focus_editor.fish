#!/usr/bin/env fish

# # helix_foundをfalseに初期化
# set helix_found false
#
# # pane数を取得
# set pane_count (zellij action dump-layout | grep pane | grep size= | grep % | grep -v command | grep -v direction | wc -l)
#
# # pane数だけループ
# for i in (seq 1 $pane_count)
#     if not test (zellij action list-clients | grep " helix ")
#         # helixでない場合、zellijでnext paneに移動
#         zellij action focus-next-pane
#     else
#         # helixが見つかったらhelix_foundをtrueに設定し、ループを抜ける
#         set helix_found true
#         break
#     end
# end
#
# # helix_foundがfalseの場合のみ、zellijで新しいpaneを開く
# if not $helix_found
#     zellij action new-pane -- helix
# end
#
zellij pipe "zjpane::focus::editor"
