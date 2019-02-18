#!/bin/sh
feh --bg-fill ~/Downloads/wpporange2.jpg
# xwinwrap -g 1920x1080 -ov -ni -s -nf -- gifview -w WID /home/brunobbs/resized.gif -a &
xinput --set-prop "ELAN0501:01 04F3:3060 Touchpad" "libinput Tapping Enabled" 1
xinput --set-prop "ELAN0501:01 04F3:3060 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "ELAN0501:01 04F3:3060 Touchpad"  "libinput Accel Speed" 0.3
# xmodmap -e "keycode 84 = Up"
# xmodmap -e "keycode 87 = Left"
# xmodmap -e "keycode 88 = Down"
# xmodmap -e "keycode 89 = Right"
# xmodmap -e "keycode 90 = End"
