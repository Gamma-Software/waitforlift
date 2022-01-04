#!/bin/bash
eval $1 &

cmdpid=$! # Get the pid from the command
music=$(cat /usr/share/waitforlift/waitforlift.conf)
mpv $music --loop &> /dev/null &> /dev/null
while [ 1 ]
do
    ps -p $cmdpid > /dev/null
    if [[ $? -ne 0 ]]; then
        pkill -9 mpv &> /dev/null
        break
    fi
    sleep 1
done
