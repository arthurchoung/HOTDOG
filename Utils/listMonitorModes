#!/usr/bin/perl

$output = `xrandr`;
@lines = split "\n", $output;

print "name,width,height,current,preferred\n";

$name = undef;

foreach $line (@lines) {
    if ($line =~ m/ connected /) {
        $line =~ s/ connected / /;
        $line =~ s/ primary / /;
        if ($line =~ m/^([^\s]+)\s+(\d+)x(\d+)/) {
            $name = $1;
            next;
        }
    }
    if ($line =~ m/^\s+(\d+)x(\d+)\s+\d+/) {
        $width = $1;
        $height = $2;
        $current = '0';
        if ($line =~ m/\*/) {
            $current = '1';
        }
        $preferred = '0';
        if ($line =~ m/\+/) {
            $preferred = '1';
        }
        print "$name,$width,$height,$current,$preferred\n";
    }

}

