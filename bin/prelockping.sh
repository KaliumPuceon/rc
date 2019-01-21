#! /bin/bash
if ! pgrep -x "i3lock" > /dev/null; then
    playsound /home/kalium/.local/share/sounds/open.ogg
fi
