#!/usr/bin/perl

#$output = `blkid`;
#@lines = split "\n", $output;
#foreach $line (@lines) {
#    $device = undef;
#    if ($line =~ m/^([^:]+):/) {
#        $device = $1;
#    }
#    $type = undef;
#    if ($line =~ m/TYPE=\"([^\"]+)\"/) {
#        $type = $1;
#    }
#    $label = undef;
#    if ($line =~ m/LABEL=\"([^\"]+)\"/) {
#        $label = $1;
#    }
#    print "device:$device type:$type label:$label\n";
#}

use JSON;

sub asQuotedString
{
    my ($str) = @_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/\"/\\\"/g;
    return '"' . $str . '"';
}

$output = `lsblk --json -l -p -o PATH,FSTYPE,SIZE,MOUNTPOINT,LABEL`;
$result = decode_json($output);
$blockdevices = $result->{'blockdevices'};
foreach $elt (@$blockdevices) {
    print "device:$elt->{path} fstype:$elt->{fstype} size:$elt->{size} mountpoint:$elt->{mountpoint} label:$elt->{label}\n";
}
