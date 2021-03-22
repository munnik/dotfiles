compton --backend glx --paint-on-overlay --vsync opengl-swc -b
xsetroot -solid grey &
~/.config/fehbg/fehbgrc &
xset fp+ /usr/local/share/fonts/
xset fp+ ~/.local/share/fonts/
xset s 300 5
export XSECURELOCK_AUTH_TIMEOUT=5
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_LIST_VIDEOS_COMMAND="find ~/.config/screensaver/ -type f"
export XSECURELOCK_PASSWORD_PROMPT=time_hex
export XSECURELOCK_SAVER=saver_mpv
export XSECURELOCK_SHOW_HOSTNAME=0
xss-lock -n /usr/libexec/xsecurelock/saver_mpv -l -- env xsecurelock &
xmodmap -e "pointer = 1 2 3 5 4 6 7 8 9 10"
exec bspwm
