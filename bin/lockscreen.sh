#! /bin/bash

if ! pgrep -x "i3lock" > /dev/null; then

    i3lock --image=`ls -d /home/kalium/media/img/wallpaper/lockscreen /home/kalium/media/img/wallpaper/lockscreen/* |grep png| sort -R | head -n 1` -e

fi
