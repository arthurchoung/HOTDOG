#!/bin/bash

killall compton

if [ "x${HOTDOG_MODE}" = "xaqua" ]; then
    BASEDIR=`hotdog configDir`
    compton -c -b
    feh --bg-tile "$BASEDIR/Wallpaper/aqua.png"
fi

