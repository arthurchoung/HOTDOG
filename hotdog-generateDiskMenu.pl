#!/usr/bin/env perl

@lines = `geom disk list`;
chomp @lines;
%disks = ();
%diskmediasize = ();
%diskdescr = ();
$name = '';
foreach $line (@lines) {
    if ($line =~ m/^\d+\.\s+Name:\s+(.+)$/) {
        $name = $1;
        $disks{$name} = $name;
    } elsif ($name) {
        if ($line =~ m/^\s+Mediasize:\s+\d+\s+\(([^\)]+)\)/) {
            $diskmediasize{$name} = $1;
        } elsif ($line =~ m/^\s+descr:\s+(.*)/) {
            $diskdescr{$name} = $1;
        }
    }
}



@lines = `geom part list`;
chomp @lines;

$geomname = '';
$scheme = '';
$name = '';
$mediasize = '';
$type = '';

print sprintf("%-12.12s %-8.8s %-20.20s %-8.8s %-8.8s %s\n", 'NAME', 'TYPE', 'LABEL', 'SIZE', 'USED', 'MOUNTPOINT');

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
        $capacity = '';
        if ($mountpoint =~ s/^(\S+)\s+//) {
            $capacity = $1;
        }
        $mountpoint =~ s/([%\s])/sprintf '%%%02x', ord $1/eg;

        print sprintf("  %-10.10s %-8.8s %-20.20s %-8.8s %-8.8s %s\n", $name, $type, '', $mediasize, $capacity, $mountpoint);
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
    } elsif ($line =~ m/^Geom name:\s+(.+)/) {
        $geomname = $1;
        if ($disks{$geomname}) {
            print sprintf("%-12.12s %-8.8s %-20.20s %s\n", $geomname, '', $diskdescr{$geomname}, $diskmediasize{$geomname});
        }

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

