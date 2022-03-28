#!/usr/bin/perl

$output = `hotdog-listBlockDevices.pl`;
@lines = split "\n", $output;

print <<EOF;
panelHorizontalStripes
panelText:'Select the disk where you want to install Hot Dog Linux:'
panelText:''
panelLine
EOF

$disk = '';
$disksize = '';
$diskvendor = '';
$diskmodel = '';
$firstPartition = '';
$firstPartitionFSType = '';
$firstPartitionSize = '';

foreach $line (@lines) {
    $type = '';
    if ($line =~ m/\btype:([a-z]+)/) {
        $type = $1;
    }

    $device = '';
    if ($line =~ m/\bdevice:([^\s]+)/) {
        $device = $1;
        $device =~ s/\\/\\\\/g;
        $device =~ s/'/\\'/g;
    }

    $fstype = '';
    if ($line =~ m/\bfstype:([^\s]+)/) {
        $fstype = $1;
        $fstype =~ s/\\/\\\\/g;
        $fstype =~ s/'/\\'/g;
    }

    $size = '';
    if ($line =~ m/\bsize:([^\s]+)/) {
        $size = $1;
        $size =~ s/\\/\\\\/g;
        $size =~ s/'/\\'/g;
    }

    $mountpoint = '';
    if ($line =~ m/\bmountpoint:([^\s]+)/) {
        $mountpoint = $1;
        $mountpoint =~ s/\\/\\\\/g;
        $mountpoint =~ s/'/\\'/g;
    }

    $label = '';
    if ($line =~ m/\blabel:([^\s]+)/) {
        $label = $1;
        $label =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
        $label =~ s/\\/\\\\/g;
        $label =~ s/'/\\'/g;
    }

    $vendor = '';
    if ($line =~ m/\bvendor:([^\s]+)/) {
        $vendor = $1;
        $vendor =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
        $vendor =~ s/\\/\\\\/g;
        $vendor =~ s/'/\\'/g;
    }

    $model = '';
    if ($line =~ m/\bmodel:([^\s]+)/) {
        $model = $1;
        $model =~ s/%([0-9a-fA-F]{2})/chr(hex($1))/eg;
        $model =~ s/\\/\\\\/g;
        $model =~ s/'/\\'/g;
    }

    if ($type eq 'disk') {
        $disk = $device;
        $disksize = $size;
        $disklabel = $label;
        $diskvendor = $vendor;
        $diskmodel = $model;
        $firstPartition = '';
    } elsif ($type eq 'part') {
        if ($disk) {
            if (not $firstPartition) {
                $firstPartition = $device;
                $firstPartitionFSType = $fstype;
                $firstPartitionSize = $size;
                $firstPartitionLabel = $label;
            } else {
                if (not $mountpoint) {
                    print <<EOF;
panelText:''
panelText:'Vendor: $diskvendor'
panelText:'Model: $diskmodel'
panelText:'Disk Label: $disklabel'
panelText:'Disk Size: $disksize'
panelText:'Disk: $disk'
panelText:'Bootloader: $firstPartition'
panelText:'Bootloader File System: $firstPartitionFSType'
panelText:'Bootloader Label: $firstPartitionLabel'
panelText:'Bootloader Size: $firstPartitionSize'
panelText:'Device: $device'
panelText:'File System: $fstype'
panelText:'Label: $label'
panelText:'Size: $size'
panelText:''
panelButton:'Install To $device' message:[NSArray|addObject:'hotdog-installerDialog....sh'|addObject:'hotdog-installerInstallToDisk:bootPartition:systemPartition:.sh'|addObject:'$disk'|addObject:'$firstPartition'|addObject:'$device'|runCommandInBackground ; exit:0]
panelText:''
panelLine
EOF
                }
            }
        }
    }
}

