# HOT DOG Linux

For more information, please visit http://hotdoglinux.com



## Notes for Alpine

Remove these lines from build.pl:

```
-DBUILD_WITH_GNU_PRINTF
-DBUILD_WITH_GNU_QSORT_R
```

## Installation of Alpine

qemu-img create -f raw hotdoglinux.img 3G

qemu-system-i386 -enable-kvm -m 1024 -nic user -boot d -cdrom alpine-standard-3.12.3-x86.iso -drive format=raw,file=hotdoglinux.img

```
setup-alpine
poweroff
```

qemu-system-i386 -enable-kvm -m 1024 -nic user -soundhw hda -boot c -drive format=raw,file=hotdoglinux.img

```
vi /etc/apk/repositories (uncomment edge/main and edge/community, comment out both v3.12/main and v3.12/community or whatever the version is)
apk update
apk upgrade --update-cache --available
vi /boot/extlinux.conf (remove nomodeset)
sync
reboot
```

```
setup-xorg-base

apk add perl
apk add gcc
apk add gcc-objc
apk add git
apk add xterm
apk add xrandr
apk add sudo
apk add libx11-dev
apk add mesa-dev

apk add mesa-dri-swrast # for qemu / virtual box

apk add alsa-utils
apk add alsaconf
apk add alsa-lib-dev

addgroup $USER audio # for each user
addgroup root audio

rc-service alsa start
rc-update add alsa

git clone https://github.com/arthurchoung/HOTDOG
cd HOTDOG
sh makeUtils.sh
vi build.pl (remove -DBUILD_WITH_GNU_PRINTF and -DBUILD_WITH_GNU_QSORT_R)
perl build.pl

cd
vi .xinitrc (add line 'exec xterm -e $HOME/HOTDOG/hotdog runWindowManager')
startx
```


## Legal

Copyright (c) 2020 Arthur Choung. All rights reserved.

Email: arthur -at- hotdoglinux.com

Released under the GNU General Public License, version 3.

For details on the license, refer to the LICENSE file.

