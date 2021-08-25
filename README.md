# HOT DOG Linux

For more information, please visit http://hotdoglinux.com

## Download

Live Image based on Slackware Live

http://hotdoglinux.com/download/


## Screenshots

![Windows 3.1 Screenshot](Screenshots/hotdog-screenshot-win31.png)

![Amiga Screenshot](Screenshots/hotdog-screenshot-amiga.png)

![Atari ST Screenshot](Screenshots/hotdog-screenshot-atarist.png)

![Mac Classic Screenshot](Screenshots/hotdog-screenshot-macclassic.png)

![Mac Color Screenshot](Screenshots/hotdog-screenshot-maccolor.png)

![Mac Platinum Screenshot](Screenshots/hotdog-screenshot-macplatinum.png)


## Overview

The design goals of HOT DOG Linux include:

  * Graphical user interface based on retro computer systems including Windows 3.1 Hot Dog Stand, Amiga Workbench, Atari ST GEM, and Classic Mac
  * Custom lightweight Objective-C foundation
  * Bitmapped graphics, low DPI displays
  * No Unicode support by design

HOT DOG Linux uses a custom lightweight Objective-C foundation on top of the GNUstep Objective-C runtime. It does not use the GNUstep Foundation. The style of Objective-C is completely different from the one Apple uses, everything is basically **id**.

By design, Unicode is not supported.

Low DPI displays are preferred, since the graphics are bitmapped and fixed in size. The preferred aspect ratio for HOT DOG Linux is 4:3. 

HOT DOG Linux does not use Automatic Reference Counting. It causes problems with type-checking during compilation (it is too strict).

HOT DOG Linux is an acronym that stands for **H**orrible **O**bsolete **T**ypeface and **D**readful **O**nscreen **G**raphics for Linux.



## How to compile and run

$ sh makeUtils.sh

$ perl build.pl

To run the window manager:

$ ./hotdog runWindowManager

To run the iPod style interface:

$ ./hotdog



## Dependencies

The following executables must be in your PATH or at location if specified:

  * xrandr
  * ifconfig (used by hotdog-printNetworkInfo.pl)
  * find (used by build.pl)
  * gcc (also needs gcc objc runtime)
  * /usr/bin/perl (also needs JSON)
  * /bin/bash (used by Utils/printDateEverySecondForTimezone:text:)
  * date (used by Utils/printDateEverySecondForTimezone:text:)

(this list is probably incomplete)

The following libraries must have headers available and be linkable:

  * libX11
  * libXext
  * libXfixes
  * libGL (Mesa should work)
  * libpthread
  * libm



## Legal

Copyright (c) 2020 Arthur Choung. All rights reserved.

Email: arthur -at- hotdoglinux.com

Released under the GNU General Public License, version 3.

For details on the license, refer to the LICENSE file.

