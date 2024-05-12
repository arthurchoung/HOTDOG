#!/usr/bin/perl

$output = `hotdog-listBlockDevices.pl`;
@lines = split "\n", $output;
@lines = grep { m/\bfstype:[a-zA-Z0-9]+/ } @lines;

print <<EOF;
panelHorizontalStripes
EOF

$first = 1;

foreach $line (@lines) {
    if ($first) {
        $first = 0;
    } else {
        print <<EOF;
panelText:''
panelLine
EOF
    }

    $device = '';
    if ($line !~ m/\bfstype:[a-zA-Z0-9]+/) {
        next;
    }
    print <<EOF;
panelText:''
EOF
    if ($line =~ m/\bdevice:([^\s]+)/) {
        $device = $1;
        $device =~ s/\'//g;
        print <<EOF;
panelText:'Device: $device'
EOF
    }
    if ($line =~ m/\bfstype:([^\s]+)/) {
        $fstype = $1;
        $fstype =~ s/\'//g;
        print <<EOF;
panelText:'File System:$fstype'
EOF
    }
    if ($line =~ m/\bsize:([^\s]+)/) {
        $size = $1;
        $size =~ s/\'//g;
        print <<EOF;
panelText:'Size:$size'
EOF
    }
    if ($line =~ m/\bmountpoint:([^\s]+)/) {
        $mountpoint = $1;
        $mountpoint =~ s/\'//g;
        print <<EOF;
panelButton:'Open $mountpoint' message:[NSArray|addObject:'hotdog'|addObject:'open'|addObject:'$mountpoint'|runCommandInBackground]
EOF
        if ($mountpoint ne '/') {
            print <<EOF;
panelText:''
panelButton:'Unmount $mountpoint' message:[NSArray|addObject:'hotdog-unmountDrive.pl'|addObject:'$mountpoint'|runCommandAndReturnOutput;updateArray]
EOF
        }
    } else {
        print <<EOF;
panelButton:'Mount $device' message:[NSArray|addObject:'hotdog-mountDrive.pl'|addObject:'$device'|runCommandAndReturnOutput;updateArray]
EOF
    }
}

