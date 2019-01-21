#!/bin/bash

if cmus-remote -Q | grep "paused" > /dev/null
then
    PLAYING="[🔈]"
else
    PLAYING="[🔊]"
fi

if pgrep -x "cmus" > /dev/null # is cmus running
then
    DATA=$(cmus-remote -Q)
    START=$(echo "$DATA" | grep "tag\ title" | head -n 1 | cut -d ' ' -f 3-)
    END=$(echo "$DATA" | grep "tag\ artist" | head -n 1 | cut -d ' ' -f 3-)
    STREAM=$(echo "$DATA" | grep "^stream"|head -n 1|cut -d ' ' -f 2-)
    #TITLE=$PLAYING" "${START:0:40}" 🎵 "${END:0:30}${STREAM:0:50}
    TITLE=$PLAYING" "${START:0:80}" 🎵 "${END:0:80}${STREAM:0:80}
else
    TITLE="[cmus off 🔇]"
fi

echo $TITLE
