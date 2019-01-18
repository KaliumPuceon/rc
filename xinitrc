if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

systemctl --user import-environment DISPLAY

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
redshift & 
export $XDG_RUNTIME_DIR="/run/user/1000/"
xrandr --dpi 75
exec i3
#exec flwm
#exec sway
