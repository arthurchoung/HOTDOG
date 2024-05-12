#!/usr/bin/env perl

print <<EOF;
Horrible Obsolete Typeface and Dreadful Onscreen Graphics (HOTDOG)

Written by Arthur Choung
EOF

print "\n\nProcessors:\n\n";
$processor = undef;
$cpuinfo = `cat /proc/cpuinfo`;
foreach $line (split '\n', $cpuinfo) {
    if ($line =~ m/^processor\s:\s*([^\n]+)/) {
        $processor = $1;
    } elsif ($line =~ m/model name\s*:\s*([^\n]+)/) {
        print "$1 ($processor)\n";
        $processor = undef;
    }
}

print "\nGraphics:\n";
$lspci = `lspci`;
foreach $line (split '\n', $lspci) {
    if ($line =~ m/VGA compatible controller:\s*([^\n]+)/) {
        print "\n$1\n";
    }
}

