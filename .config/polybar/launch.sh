#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
pkill ibus-daemon
setxkbmap -layout us,ir -option grp:caps_toggle
xmodmap -e "keycode 133 = Super_L"
xmodmap -e "keycode 135 = ISO_Next_Group"
bash ~/.screenlayout/dual_up.sh
xset +dpms
xset dpms 300

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

m=$(xrandr --query | grep " connected" | grep -v primary | cut -d" " -f1)
cmd=(env "MONITOR=$m" /usr/local/bin/polybar --reload main)

if [[ $# -gt 0 ]] && [[ $1 = "block" ]]; then
	exec "${cmd[@]}"
else
	"${cmd[@]}" &
fi
