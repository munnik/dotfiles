#!/bin/sh

wifi_print() {
    ifconfig iwm0 | grep 'status: active'

    if [ $? -eq 0 ]; then
        icon="直"
        connection=$(ifconfig iwm0 | awk '/ieee80211:/ { print $3 "@" $8 }')
    else
        icon="睊"
        connection="-"
    fi
    echo "%{F#555}$icon%{F-} $connection"
}

path_pid="/tmp/polybar-wifi.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            wifi_print

            sleep 5 &
            wait
        done
        ;;
esac
