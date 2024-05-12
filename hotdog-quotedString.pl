#!/usr/bin/env perl

while ($line = <STDIN>) {
    chomp $line;
    $line =~ s/\\/\\\\/g;
    $line =~ s/"/\\"/g;
    print '"' . $line . '"' . "\n";
}

#    $line =~ s/\\/\\\\/g;
#    $line =~ s/\"/\\\"/g;
