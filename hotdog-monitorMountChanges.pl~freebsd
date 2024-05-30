#!/usr/bin/env perl

$|=1;

$path = '/var/run/devd.seqpacket.pipe';

open(FH, "cat $path |") or die("unable to open $path");

while ($line = <FH>) {
    chomp $line;
    if ($line !~ m/\bsystem=VFS\b/) {
        next;
    }
    if ($line !~ m/\bsubsystem=FS\b/) {
        next;
    }
    if ($line =~ m/\btype=MOUNT\b/) {
        print "$line\n";
    } elsif ($line =~ m/\btype=UNMOUNT\b/) {
        print "$line\n";
    }
}

close(FH);


