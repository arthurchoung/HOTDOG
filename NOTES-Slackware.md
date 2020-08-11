# HOT DOG Linux

For more information, please visit http://hotdoglinux.com



## Notes for Slackware

The dependencies should already be installed as part of the base system.

Create a file as root at /etc/X11/xinit/xinitrc.xterm with these contents:

(this is just a slightly modified version of /etc/X11/xinit/xinitrc.twm)
```
#!/bin/sh
# $Xorg: xinitrc.cpp,v 1.3 2000/08/17 19:54:30 cpqbld Exp $

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    /usr/bin/xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    /usr/bin/xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    /usr/bin/xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    /usr/bin/xmodmap $usermodmap
fi

# start some nice programs

exec /usr/bin/xterm
```

Then you can run **xwmconfig** (as a user, not as root) to choose a different
xinitrc, or you can just run:

```
startx /etc/X11/xinit/xinitrc.xterm
```

to start X.

From the xterm you can run the HOT DOG Linux window manager.

You can customize this as you like.



## Legal

Copyright (c) 2020 Arthur Choung. All rights reserved.

Email: arthur -at- hotdoglinux.com

Released under the GNU General Public License, version 3.

For details on the license, refer to the LICENSE file.

