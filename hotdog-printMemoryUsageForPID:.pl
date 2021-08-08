#!/usr/bin/perl

$|=1;

use strict;

my $pid = shift @ARGV;
if (not $pid) {
    die;
}

my $lastLine = '';

for(;;) {
    my $output  = `cat /proc/$pid/status`;
    if (not $output) {
        last;
    }

    my @lines = split '\n', $output;

    foreach my $line (@lines) {
        if ($line =~ m/^VmRSS:/) {
            $line =~ s/\t//g;
            my @tokens = split ' ', $line;
            $line = "Mem: $tokens[1] $tokens[2]";
            if ($line ne $lastLine) {
                print "$line\n";
                $lastLine = $line;
            }
        }
    }

    sleep 1;
}
