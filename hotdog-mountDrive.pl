#!/usr/bin/perl

$device = shift @ARGV;
if (not $device) {
    die('specify device');
}

for(;;) {
loop:
    $mountpoint = `hotdog dialog mac --stdout --inputbox "Enter mount point for $device:" 1 1`;
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

    system('hotdog', 'open', $mountpoint);

    exit 0;
}


