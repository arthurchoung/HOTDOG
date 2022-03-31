# HOTDOGbuntu

## Notes for Ubuntu and derivatives

(Tested with Linux Mint 20.3)

Download the .deb file from http://hotdoglinux.com/download/

You'll also need the following packages installed:

```
sudo apt install libjson-perl
sudo apt install feh
sudo apt install compton
```

Install the .deb file:

```
dpkg -i HOTDOGbuntu_xxxxxxxx_amd64.deb
```

Log out, change the window manager from the login screen, then log back in.

Some things don't work properly when running on Ubuntu, for various reasons.

This is just to see if it runs. Slackware is preferred.

## To compile

```
sudo apt install git
sudo apt install gobjc
sudo apt install libx11-dev
sudo apt install libxext-dev
sudo apt install libxfixes-dev
sudo apt install libgl-dev
sudo apt install libasound-dev
sudo apt install g++

sudo apt install libjson-perl
sudo apt install feh
sudo apt install compton

git clone https://github.com/arthurchoung/HOTDOG
cd HOTDOG
```

Edit build.pl at the top of the file to point to this library:

```
/usr/lib/gcc/x86_64-linux-gnu/9/libobjc.a
```

Then:

```
perl build.pl
sh makeUtils.sh
./hotdog
```

## To make a .deb

```
cd Ubuntu
sudo sh make_deb.sh
```

## Legal

Copyright (c) 2020 Arthur Choung. All rights reserved.

Email: arthur -at- hotdoglinux.com

Released under the GNU General Public License, version 3.

For details on the license, refer to the LICENSE file.

