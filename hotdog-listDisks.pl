#!/usr/bin/env perl

#@lines = `geom disk list`;
@lines = `geom part list`;
chomp @lines;

$name = '';
$mediasize = '';
$type = '';

sub print_elt
{
    if ($name) {
        @dflines = `df /dev/$name 2>/dev/null`;
        chomp @dflines;
        shift @dflines;
        $mountpoint = shift @dflines;
        $mountpoint =~ s/^\S+\s+//;
        $mountpoint =~ s/^\S+\s+//;
        $mountpoint =~ s/^\S+\s+//;
        $mountpoint =~ s/^\S+\s+//;
        $mountpoint =~ s/^\S+\s+//;
        $mountpoint =~ s/([%\s])/sprintf '%%%02x', ord $1/eg;

        print "device:/dev/$name type:part fstype:$type size:$mediasize mountpoint:$mountpoint\n";
    }

    $name = '';
    $mediasize = '';
    $type = '';
}

$providers = 0;

foreach $line (@lines) {
    if ($line =~ m/^Providers:/) {
        $providers = 1;
    } elsif ($line =~ m/^Consumers:/) {
        $providers = 0;
    } elsif ($line =~ m/^\d+\.\s+Name:\s+(.+)$/) {
        $newName = $1;
        print_elt();

        if ($newName =~ m/^diskid\//) {
        } elsif ($providers) {
            $name = $newName;
        }
    } elsif ($name) {
        if ($line =~ m/^\s+Mediasize:\s+\d+\s+\(([^\)]+)\)/) {
            $mediasize = $1;
        } elsif ($line =~ m/^\s+type:\s+(.*)/) {
            $type = $1;
        }
    }
}


exit 0;

