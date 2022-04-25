#!/bin/bash

killall compton

if [ "x${HOTDOG_MODE}" = "xamiga" ]; then
    xsetroot -solid '#0055aa'
elif [ "x${HOTDOG_MODE}" = "xaqua" ]; then
    BASEDIR=`hotdog configDir`
    compton -c -b
    feh --bg-tile "$BASEDIR/Wallpaper/aqua.png"
elif [ "x${HOTDOG_MODE}" = "xatarist" ]; then
    xsetroot -solid '#00ff00'
elif [ "x${HOTDOG_MODE}" = "xhotdogstand" ]; then
    xsetroot -solid '#ffff00'
elif [ "x${HOTDOG_MODE}" = "xmacclassic" ]; then
    BASEDIR=`hotdog configDir`
    xsetroot -bitmap "$BASEDIR/Wallpaper/macclassic.xbm" -bg '#606060' -fg '#a0a0a0'
elif [ "x${HOTDOG_MODE}" = "xmaccolor" ]; then
    BASEDIR=`hotdog configDir`
    xsetroot -bitmap "$BASEDIR/Wallpaper/maccolor.xbm" -bg '#606060' -fg '#a0a0a0'
elif [ "x${HOTDOG_MODE}" = "xmacplatinum" ]; then
    BASEDIR=`hotdog configDir`
    feh --bg-tile "$BASEDIR/Wallpaper/macplatinum.xpm"
fi

