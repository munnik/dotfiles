#!/bin/sh

battery_print() {
    ac=$(apm -a)
    battery_percent=$(apm -l)

    if [ "$ac" -eq 1 ]; then
        if [ "$battery_percent" -gt 90 ]; then
            icon=""
        elif [ "$battery_percent" -gt 80 ]; then
            icon=""
        elif [ "$battery_percent" -gt 70 ]; then
            icon=""
        elif [ "$battery_percent" -gt 50 ]; then
            icon=""
        elif [ "$battery_percent" -gt 30 ]; then
            icon=""
        elif [ "$battery_percent" -gt 20 ]; then
            icon=""
        else
            icon=""
        fi
    else
        if [ "$battery_percent" -gt 90 ]; then
            icon=""
        elif [ "$battery_percent" -gt 80 ]; then
            icon=""
        elif [ "$battery_percent" -gt 70 ]; then
            icon=""
        elif [ "$battery_percent" -gt 60 ]; then
            icon=""
        elif [ "$battery_percent" -gt 50 ]; then
            icon=""
        elif [ "$battery_percent" -gt 40 ]; then
            icon=""
        elif [ "$battery_percent" -gt 30 ]; then
            icon=""
        elif [ "$battery_percent" -gt 20 ]; then
            icon=""
        elif [ "$battery_percent" -gt 10 ]; then
            icon=""
        else
            icon=""
        fi
    fi
    echo "%{F#555}$icon%{F-} $battery_percent%"
}

path_pid="/tmp/polybar-battery.pid"

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
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
