# 1
firefox &
sleep 1

# 2
xdotool key super+2
alacritty -e tmux &
sleep 1

# 4
xdotool key super+4
tusk &
sleep 3

# 3 do last for resolve keyring.
xdotool key super+3
todoist &
sleep 3
TogglDesktop.sh &
sleep 1


