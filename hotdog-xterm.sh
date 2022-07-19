#!/bin/bash

FONT=""
if [ $HOTDOG_SCALING -gt 1 ]; then
    FONT="-fn 12x24"
fi

if [ "x$HOTDOG_MODE" = "xamiga" ]; then
    xterm $FONT -geometry 80x50 -bg '#0055aa' -fg white -cr '#ff8800' +bc +uc
elif [ "x$HOTDOG_MODE" = "xhotdogstand" ]; then
    xterm $FONT -geometry 80x50 -bg '#0055aa' -fg white -cr '#ffff00' +bc +uc
elif [ "x$HOTDOG_MODE" = "xaqua" ]; then
    xterm $FONT -geometry 80x50 -bg black -fg white -cr '#ffff00' +bc +uc
elif [ "x$HOTDOG_MODE" = "xwinmac" ]; then
    xterm $FONT -geometry 80x50 -bg black -fg white -cr '#ffff00' +bc +uc
else
    xterm $FONT -geometry 80x50 -bg white -fg black +bc +uc
fi
#    xterm -geometry 80x50 +bc +uc

