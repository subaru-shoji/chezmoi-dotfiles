#!/usr/bin/env fish

# # kak -l | grep $ZELLIJ_SESSION_NAME の結果が空であるか確認
# if test -z (kak -l | grep $ZELLIJ_SESSION_NAME)
#     # 空であれば、zellijで新しいpaneを開きつつkak -s $ZELLIJ_SESSION_NAME
#     zellij action new-pane -- kak -s $ZELLIJ_SESSION_NAME
# end
#
# echo "evaluate-commands -client client0 'edit $argv'" | kak -p $ZELLIJ_SESSION_NAME

ide_zellij_focus_editor.fish

zellij action write 27 # Escape
zellij action write-chars ":open $argv"
zellij action write 13 # Enter
