#! /bin/bash
if pgrep -x "xautolock" > /dev/null
then
    echo "xautolock already running!"
else
    xautolock -detectsleep -time 4 -locker  "/home/kalium/.local/bin/lockscreen.sh" -corners --00 -cornersize 80 -notify 15 -bell 40 &  # Start autolocker
fi
