#!/bin/sh
#
# Adapted from Slackware and Slackware Live installer
#

ROOTDIR="/mntsystem"
if ! [ -d "$ROOTDIR" ]; then
    echo "Error, $ROOTDIR either does not exist or is not a directory"
    exit 1
fi

ROOTDEVICE=$( findmnt -P -M $ROOTDIR | sed 's/.*SOURCE="\([^"]*\)".*/\1/' )
if [ "x$ROOTDEVICE" = "x" ]; then
    echo "Error, $ROOTDIR is not mounted with system"
    exit 1
fi

UUID=$( blkid -s UUID -o value $ROOTDEVICE )
if [ "x$UUID" = "x" ]; then
    echo "Error, unable to get UUID"
    exit 1
fi

#
# Install Packages in /InstallerPackages*
#

COUNT=$( find /InstallerPackages*/*.t?z | wc -l )
INDEX=1

for package in /InstallerPackages*/*.t?z ; do
    echo "[$INDEX/$COUNT]"
    echo
    if ! installpkg -root $ROOTDIR -terse -priority ADD $package ; then
        echo "Unable to install $package, aborting installation..."
        exit 1
    fi
    echo -e -n "\r"
    ((INDEX++))
done

$ROOTDIR/sbin/ldconfig -r $ROOTDIR

#
# Generate /etc/fstab
#

echo "Generating /etc/fstab..."
echo -e -n "\r"

cat /dev/null > $ROOTDIR/etc/fstab
printf "%s %-16s %-11s %-16s %-3s %s\n" "UUID=\"$UUID\"" "/" "ext4" "defaults" "1" "1" >> $ROOTDIR/etc/fstab
printf "%-16s %-16s %-11s %-16s %-3s %s\n" "#/dev/cdrom" "/mnt/cdrom" "auto" "noauto,owner,ro,comment=x-gvfs-show" "0" "0" >> $ROOTDIR/etc/fstab
printf "%-16s %-16s %-11s %-16s %-3s %s\n" "/dev/fd0" "/mnt/floppy" "auto" "noauto,owner" "0" "0" >> $ROOTDIR/etc/fstab
printf "%-16s %-16s %-11s %-16s %-3s %s\n" "devpts" "/dev/pts" "devpts" "gid=5,mode=620" "0" "0" >> $ROOTDIR/etc/fstab
printf "%-16s %-16s %-11s %-16s %-3s %s\n" "proc" "/proc" "proc" "defaults" "0" "0" >> $ROOTDIR/etc/fstab
printf "%-16s %-16s %-11s %-16s %-3s %s\n" "tmpfs" "/dev/shm" "tmpfs" "nosuid,nodev,noexec" "0" "0" >> $ROOTDIR/etc/fstab

#
# Copy /InstallerCustom*
#

for custom in /InstallerCustom* ; do
    echo "Copying $custom..."
    echo -e -n "\r"
    cp -a -T $custom $ROOTDIR
done

# If running in Amiga mode then use the Amiga xdm config
# Else If running in Aqua mode then use the Aqua xdm config
# Else use the Mac xdm config

echo "Setting /etc/X11/xinit/xinitrc..."
echo -e -n "\r"

rm $ROOTDIR/etc/X11/xinit/xinitrc
if [ "x$HOTDOG_MODE" = "xamiga" ]; then
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xresources~amiga" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xresources"
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xsetup~amiga" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xsetup"
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/slackware_traditional.svg~amiga" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/slackware_traditional.svg"
    ln -s xinitrc.hotdogamiga $ROOTDIR/etc/X11/xinit/xinitrc
elif [ "x$HOTDOG_MODE" = "xaqua" ]; then
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xresources~aqua" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xresources"
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xsetup~aqua" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xsetup"
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/slackware_traditional.svg~aqua" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/slackware_traditional.svg"
    ln -s xinitrc.hotdogaqua $ROOTDIR/etc/X11/xinit/xinitrc
else
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xresources~mac" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xresources"
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xsetup~mac" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/Xsetup"
    cp "$ROOTDIR/etc/X11/xdm/liveslak-xdm/slackware_traditional.svg~mac" "$ROOTDIR/etc/X11/xdm/liveslak-xdm/slackware_traditional.svg"
    ln -s xinitrc.hotdogmac $ROOTDIR/etc/X11/xinit/xinitrc
fi

#
# Done
#

echo "$COUNT packages installed."
echo -e -n "\r"

exit 0

