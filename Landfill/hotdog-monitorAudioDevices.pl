#!/usr/bin/perl

$|=1;

open FH, "udevadm monitor |" or die('unable to run udevadm monitor');
while ($line = <FH>) {
    chomp $line;
    if ($line =~ m/^UDEV/) {
        if ($line =~ m/\(sound\)$/) {
            print "$line\n";
        }
    }
}
close FH;

