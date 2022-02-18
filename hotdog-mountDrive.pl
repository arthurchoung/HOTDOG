#!/usr/bin/perl

$device = shift @ARGV;
if (not $device) {
    die('specify device');
}

for(;;) {
loop:
    # FIXME
    @mountlist = `hotdog-listBlockDevices.pl | allValuesForKey: mountpoint | sed '/^\$/d'`;
    chomp @mountlist;
    $mountlist = join ' ', @mountlist;

    $text = <<EOF;
Enter mount point for $device:
(mount points that are already in use: $mountlist)
EOF

    $mountpoint = `hotdog dialog mac --stdout --inputbox "$text" 1 1`;
    chomp $mountpoint;
    if ($? != 0) {
        exit 1;
    }
    if (not $mountpoint) {
        exit 0;
    }
    $output = `hotdog-listBlockDevices.pl`;
    @lines = split "\n", $output;
    foreach $line (@lines) {
        if ($line =~ m/\bmountpoint:([^\s]+)/) {
            $str = $1;
            $str =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
            if ($mountpoint eq $str) {
                # FIXME: should sanitize $mountpoint
                `echo "$mountpoint is already in use" | hotdog alert`;
                goto loop;
            }
        }
    }

    system('sudo', '-A', 'mount', $device, $mountpoint);
    if ($? != 0) {
        `echo "Unable to mount $device at $mountpoint" | hotdog alert`;
        exit 1;
    }

    exit 0;
}


