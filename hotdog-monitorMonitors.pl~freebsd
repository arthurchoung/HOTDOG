#!/usr/bin/env perl

$|=1;

$path = '/var/run/devd.seqpacket.pipe';

open(FH, "cat $path |") or die("unable to open $path");

while ($line = <FH>) {
    chomp $line;
    if ($line !~ m/\bsystem=DRM\b/) {
        next;
    }
    if ($line !~ m/\bsubsystem=CONNECTOR\b/) {
        next;
    }
    if ($line !~ m/\btype=HOTPLUG\b/) {
        next;
    }
    print "$line\n";
}

close(FH);


