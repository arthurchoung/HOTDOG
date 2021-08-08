#!/usr/bin/perl

use JSON;

sub asQuotedString
{
    my ($str) = @_;
    $str =~ s/\\/\\\\/g;
    $str =~ s/\"/\\\"/g;
    return '"' . $str . '"';
}

$output = `lsblk -f --list --paths --json`;
$result = decode_json($output);
$blockdevices = $result->{'blockdevices'};
$keys = 'name,label,mountpoint,fstype,uuid';
print "$keys\n";
foreach $elt (@$blockdevices) {
    @tokens = map { ($elt->{$_}) ? asQuotedString($elt->{$_}) : '' } split ',', $keys;
    print join ',', @tokens;
    print "\n";
}
