#!/usr/bin/perl

if (open FH, "| hotdog alert") {
    print FH <<EOF;
Horrible Obsolete Typeface and Dreadful Onscreen Graphics for Linux (HOT DOG Linux)

Written by Arthur Choung
EOF
    close FH;
}
