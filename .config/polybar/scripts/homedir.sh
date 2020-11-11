#!/bin/sh


homedir_print() {
  used=$(/sbin/zfs get -H -o value -p used rpool/home)
  avail=$(/sbin/zfs get -H -o value -p avail rpool/home)

  echo "$(echo "$used/($used+$avail)*100" | bc)%"
}

path_pid="/tmp/polybar-homedir.pid"

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
            homedir_print

            sleep 30 &
            wait
        done
        ;;
esac
