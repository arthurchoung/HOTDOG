The migration to FreeBSD was unsuccessful, it seems that I have been deported back to Linux-land.

The only problem is that Wine does not seem to be fully functional. If this can be fixed, then the migration can proceed.

It appears to work with the 32-bit kernel, but for some reason it takes forever to start-up. So perhaps it has something to do with the 32-bit/64-bit code.

Tried to compile Wine on NetBSD but it needs a bit of patching.

OpenBSD does not seem to support Wine.

Looks like I am stuck with Linux.

# configuration

```
pkg install bash
pkg install vim
pkg install xorg
pkg install chromium
pkg install git
pkg install drm-kmod
pkg install fusefs-ntfs
# kldload fusefs
# sysrc kld_list+=fusefs

edit /etc/rc.conf:
# sysrc kld_list+=radeonkms

pkg install wine
pkg install wine-mono
pkg install wine-gecko
/usr/local/share/wine/pkg32.sh install wine mesa-dri
pkg install emscripten
pkg install p5-HTTP-Server-Simple
pkg install mutt
pkg install msmtp
pkg install ImageMagick

pkg install dmidecode
pkg install xclip
pkg install p5-JSON
pkg install mupdf
pkg install sudo
pkg install feh
pkg install vobject
pkg install py39-pillow
pkg install py39-mutagen
pkg install mpv
pkg install vgmplay
pkg install rsync
```

