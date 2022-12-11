#!/usr/bin/perl

$text = <<EOF;
Run:

# xrandr --listproviders

If you are using the 'modesetting' driver, then you should switch to either the 'intel', 'radeon', or 'amdgpu' driver depending on your GPU, and enable 'TearFree'.

--- /etc/X11/xorg.conf.d/20-intel.conf

Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
EndSection

--- /etc/X11/xorg.conf.d/20-amdgpu.conf

Section "Device"
  Identifier "AMDGPU"
  Driver "amdgpu"
  Option "TearFree" "true"
EndSection

--- /etc/X11/xorg.conf.d/20-radeon.conf

Section "Device"
  Identifier "Radeon"
  Driver "radeon"
  Option "TearFree" "on"
EndSection

---

If you have an NVidia GPU, I can't remember what to do, sorry.
EOF

system('hotdog', 'oldman', $text);

