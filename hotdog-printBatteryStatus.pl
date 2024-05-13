#!/usr/bin/env perl

$|=1;

for (;;) {
    @lines = `acpiconf -i 0`;
    chomp @lines;

    $state = '';
    $remaining = '';
    foreach $line (@lines) {
        if ($line =~ m/^State:\s+(.+)/) {
            $state = $1;
        }
        if ($line =~ m/^Remaining capacity:\s+(.+)/) {
            $remaining = $1;
        }
    }

    $str = 'Battery';
    if ($state eq 'high') {
        $str = "Charged: $remaining";
    } elsif ($state eq 'discharging') {
        $str = "Discharging: $remaining";
    } elsif (not $state) {
        $str = 'No battery';
    }

    print "$str\n";

    sleep 10;
}

