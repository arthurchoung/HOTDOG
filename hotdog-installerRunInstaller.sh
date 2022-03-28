#!/bin/bash

if ! PATH="/root:$PATH" dialog \
  --yes-label "Continue" \
  --no-label "Stop" \
  --defaultno --yesno \
"\
\n\
Before installing, you must first partition the disk either as MBR or GPT.\n\
\n\
For an MBR disk, the first partition must be vfat (type 'c') and will be used for the bootloader. 100 MB is sufficient. It must be marked as bootable.\n\
\n\
For a GPT disk, the first partition must be EFI System (type 'ef00') and will be used for the bootloader. 100 MB is sufficient.\n\
\n\
Any other partition may be used as the root partition.\n\
\n\
Both partitions must be formatted before running the installer.\n\
\n\
To erase MBR/GPT data from a disk: sgdisk -Z /dev/sdx\n\
\n\
To partition an MBR disk: fdisk /dev/sdx\n\
\n\
To partition a GPT disk: gdisk /dev/sdx\n\
\n\
To format a partition as vfat: mkfs.vfat /dev/sdx1\n\
\n\
To format a partition as ext4: mkfs.ext4 /dev/sdx2\n\
\n\
To set up the installation of Hot Dog Linux, click Continue.\
"\
  16 64 ; then
    exit 1
fi

hotdog show "Panel:'hotdog-installerGeneratePanel.pl' observer:'hotdog-monitorBlockDevices'"

