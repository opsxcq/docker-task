#!/bin/bash


mode=$1
if [ -z "$mode" ]
then
    mode='cron'
fi

if [ '$mode' == 'cron' ]
then
    interval=$2
    if[ -z "$interval" ]
    then
        interval=3600
    fi
    # Simulate the cron
    while true
    do
        echo '[+] Executing task '$(date)
        if [ ! -f '/task.sh' ]
        then
            echo '[-] /task.sh missing...'
        else
            /task.sh
        fi
        sleep $interval
    done
fi
