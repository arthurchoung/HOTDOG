#!/usr/bin/env perl

print <<EOF;
Horrible Obsolete Typeface and Dreadful Onscreen Graphics (HOTDOG)

Written by Arthur Choung
EOF

print "\n\nProcessor:\n\n";
$processor = undef;
$cpuinfo = `sysctl hw.model`;
chomp $cpuinfo;
$cpuinfo =~ s/^hw\.model:\s+//;
print "    $cpuinfo\n";

print "\nGraphics:\n\n";
@lines = `pciconf -vl | grep -B3 VGA`;
chomp @lines;
foreach $line (@lines) {
    if ($line =~ m/\s*vendor\s*=\s*(.+)/) {
        $str = $1;
        $str =~ s/^\'//;
        $str =~ s/\'$//;
        print "    $str\n";
    } elsif ($line =~ m/\s*device\s*=\s*(.+)/) {
        $str = $1;
        $str =~ s/^\'//;
        $str =~ s/\'$//;
        print "    $str\n";
    }
}

