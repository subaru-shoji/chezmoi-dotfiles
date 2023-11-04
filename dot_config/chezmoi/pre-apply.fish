#!/usr/bin/env fish

set BASE_DIR ~/.local/share/chezmoi/dot_config/i3blocks/i3blocks-contrib
chmod +x \
	$BASE_DIR/memory/memory\
  $BASE_DIR/load_average/load_average\
  $BASE_DIR/battery2/battery2\
  $BASE_DIR/calendar/calendar\
  $BASE_DIR/cpu_usage/cpu_usage
