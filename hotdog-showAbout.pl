#!/usr/bin/perl

$arg = '';
if ($ENV{'HOTDOG_MODE'} eq 'amiga') {
    $arg = 'amiga';
}

if (open FH, "| hotdog ${arg}alert") {
    print FH <<EOF;
Horrible Obsolete Typeface and Dreadful Onscreen Graphics for Linux (HOT DOG Linux)

Written by Arthur Choung
EOF
    close FH;
}

