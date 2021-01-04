# HOT DOG Linux

For more information, please visit http://hotdoglinux.com



## Notes for Alpine

Remove this line in build.pl:

```
-DBUILD_WITH_GNU_PRINTF
```

## Installation of Alpine

(after fresh sys install)

vi /boot/extlinux.conf (remove nomodeset)
vi /etc/apk/repositories (uncomment edge/main and edge/community, comment out both v3.12/main and v3.12/community or whatever the version is)
apk update
apk upgrade --update-cache --available
sync
reboot

setup-xorg-base

apk add perl
apk add clang
apk add gcc
apk add git
apk add xterm
apk add xrandr
apk add musl-dev
apk add libx11-dev
apk add mesa-dev

apk add mesa-dri-swrast # for virtual box

apk add alsa-utils
apk add alsa-utils-doc
apk add alsa-lib
apk add alsaconf
apk add alsa-lib-dev

addgroup $USER audio # for each user
addgroup root audio

rc-service alsa start
rc-update add alsa

git clone https://github.com/arthurchoung/HOTDOG
cd HOTDOG
sh makeExternal.sh
sh makeUtils.sh
vi build.pl (remove -DBUILD_WITH_GNU_PRINTF)
perl build.pl

cd
vi .xinitrc (exec xterm)
startx
HOTDOG/hotdog runWindowManager


## Legal

Copyright (c) 2020 Arthur Choung. All rights reserved.

Email: arthur -at- hotdoglinux.com

Released under the GNU General Public License, version 3.

For details on the license, refer to the LICENSE file.

