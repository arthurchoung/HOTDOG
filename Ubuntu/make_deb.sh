#!/bin/bash

PRGNAM="HOTDOGbuntu"
VERSION="20220331"
SRC=".."
PKG="${PRGNAM}_${VERSION}_amd64"

# The binaries end up in /usr/bin
mkdir -p $PKG/usr/bin
find $SRC/hotdog* -executable -type f -exec cp -a {} $PKG/usr/bin \;
# Configuration files end up in /etc/HOTDOG
mkdir -p $PKG/etc/HOTDOG
cp -a $SRC/Config $SRC/MainMenu $SRC/Wallpaper $PKG/etc/HOTDOG
mkdir -p $PKG/etc/HOTDOG/Temp
chmod 1777 $PKG/etc/HOTDOG/Temp
mkdir -p $PKG/usr/share/xsessions
cp -a $SRC/Ubuntu/hotdogbuntu*.sh $PKG/usr/bin
cp -a $SRC/Ubuntu/hotdogbuntu*.desktop $PKG/usr/share/xsessions

# Strip binaries and libraries - this can be done with 'make install-strip'
# in many source trees, and that's usually acceptable, if not, use this:
find $PKG -print0 | xargs -0 file | grep -e "executable" -e "shared object" | grep ELF \
  | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null || true

# Copy program documentation into the package
# The included documentation varies from one application to another, so be sure
# to adjust your script as needed
# Also, include the SlackBuild script in the documentation directory
mkdir -p $PKG/usr/doc/$PRGNAM-$VERSION
cp -a \
  $SRC/LICENSE $SRC/README.md  \
  $PKG/usr/doc/$PRGNAM-$VERSION

mkdir -p $PKG/DEBIAN
cp -a DEBIAN/control $PKG/DEBIAN

chown -R root:root $PKG
dpkg-deb --build --root-owner-group $PKG

