#!/usr/bin/perl

$text = <<EOF;
HOTDOG is a customized version of Slackware.

Slackware packages are installed using 'slackpkg' (run as root)

First, update the package list.

# slackpkg update

To search for a package:

# slackpkg search 'text'

To install a package:

# slackpkg install 'name'

Additional packages can be installed by running 'sbopkg' as root.

# sbopkg
EOF

system('hotdog', 'oldman', $text);

