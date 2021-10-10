#!/bin/bash

if [ "x$HOTDOG_MODE" = "xamiga" ]; then
    xterm -geometry 80x50 -bg '#0055aa' -fg white -cr '#ff8800' +bc +uc
elif [ "x$HOTDOG_MODE" = "xhotdogstand" ]; then
    xterm -geometry 80x50 -bg '#0055aa' -fg white -cr '#ffff00' +bc +uc
else
    xterm -geometry 80x50 -bg white -fg black +bc +uc
fi
#    xterm -geometry 80x50 +bc +uc

