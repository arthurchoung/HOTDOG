# PEEOS

Personal Execution Environment Operating System

For more information, please visit http://peeos.org



## Notes for Ubuntu and derivatives

Before compiling, you'll need the following packages installed:

```
sudo apt install git
sudo apt install clang
sudo apt install libasound2-dev
sudo apt install libx11-dev
sudo apt install libxext-dev
sudo apt install libxfixes-dev
sudo apt install net-tools
sudo apt install inotify-tools
sudo apt install mesa-common-dev
sudo apt install xterm
```

(this can be combined into a single command)

Create a file as root at /usr/share/xsessions/xterm.desktop with these
contents:

```
[Desktop Entry]
Version=1.0
Name=xterm
Comment=xterm
Exec=xterm
Icon=
Type=Application
DesktopNames=xterm
```

This allows you to change the window manager to a simple xterm by logging out,
choosing the newly created xterm.desktop, then logging back in.

From the xterm you can run the PEEOS window manager.

You can customize this as you like.

This was tested using xubuntu-20.04-desktop-amd64.iso but it should work
for other versions as well.



## Legal

Copyright (c) 2020 Arthur Choung. All rights reserved.

Email: arthur -at- peeos.org

Released under the GNU General Public License, version 3.

For details on the license, refer to the LICENSE file.

