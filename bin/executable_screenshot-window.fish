#!/usr/bin/env fish

set FILEPATH ~/Pictures/(date "+%y%m%d%H%M%S".png)

maim -s $FILEPATH && xclip -selection clipboard -t image/png $FILEPATH

echo $FILEPATH
