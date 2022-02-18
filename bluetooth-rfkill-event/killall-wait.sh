#!/bin/sh

# Busybox killall doesn't have --wait argument, so
# here is a workaround for behaving like that.

while [ 1 ]; do
    killall $1

    if pidof $1 1>/dev/null; then
        sleep 1
        continue
    fi

    break
done
